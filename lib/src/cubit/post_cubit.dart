import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/comment_repository.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/comment.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/delete_post_state.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';
import 'package:vietnamese_learning/src/states/view_post_state.dart';
import 'package:path/path.dart';

class PostCubit extends Cubit<ViewPostState> {
  CommentRepository _commentRepository;
  PostRepository _postRepository;

  PostCubit(this._commentRepository) : super(InitialViewPost());

  Future<void> loadComments(int postId) async {
    try {
      emit(LoadingPost());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      String username = prefs.getString('username');
      UserProfile userProfile = UserProfile.fromJson(json.decode(prefs.getString(username + 'profile')));
      List<Comment> comments =
          await _commentRepository.getCommentsByPostId(postId, token);
      if (comments.isNotEmpty) {
        emit(LoadPostSuccess(comments, userProfile.fullname));
      } else {
        emit(LoadPostFailed(userProfile.fullname));
      }
    } on Exception {
      emit(LoadPostFailed('user'));
    }
  }

  Future<void> saveComment(CommentSave comment, File file) async {
    try {
      emit(CommentingPost());
      if(comment.text == ''){
        emit(CommentPostFailed());
      }else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('accessToken');
        String username = prefs.getString("username");
        if (file == null) {
          bool check = await _commentRepository.saveComment(comment, token);
          if (check == true) {
            List<Comment> comments = await _commentRepository
                .getCommentsByPostId(
                comment.postId, token);
            emit(CommentPostSuccess(comments));
          } else {
            emit(CommentPostFailed());
          }
        } else {
          await Firebase.initializeApp();
          Reference reference = FirebaseStorage.instance
              .ref()
              .child('audio_for_user_post')
              .child(username +
              "/" +
              basename(file.path) +
              '_' +
              DateTime.now().toString());

          UploadTask uploadTask = reference.putFile(file);
          uploadTask.whenComplete(() async {
            try {
              String fileUrl = await reference.getDownloadURL();
              comment.voiceLink = fileUrl;
              bool check = await _commentRepository.saveComment(comment, token);
              if (check == true) {
                List<Comment> comments = await _commentRepository
                    .getCommentsByPostId(comment.postId, token);
                emit(CommentPostSuccess(comments));
              } else {
                emit(CommentPostFailed());
              }
            } catch (onError) {
              print("Error");
            }
          });
        }
      }
    } on Exception {
      emit(CommentPostFailed());
    }
  }

  Future<void> deletePost(int postId) async{
    try {
      _postRepository = new PostRepository();
      emit(DeletingPost());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check = await _postRepository.deletePost(token, postId);
      print(check);
      if(check == true){
        emit(DeletePostSuccess());
      }
      else{
        emit(DeletePostFailed());
      }
    } on Exception {
      emit(DeletePostFailed());
    }
  }

  Future<void> deleteComment(int commentId, int postId) async{
    try{
      emit(DeletingComent());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check = await _commentRepository.deleteComment(commentId, token);
      if(check == true){
        List<Comment> comments = await _commentRepository.getCommentsByPostId(
            postId, token);
        emit(DeleteCommentSuccess(comments));
      }else{
        emit(DeleteCommentFailed());
      }
    }on Exception{
      emit(DeleteCommentFailed());
    }
  }
}
