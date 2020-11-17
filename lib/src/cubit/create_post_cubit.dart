
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState>{
  final PostRepository _postRepository;
  CreatePostCubit(this._postRepository): super(Init());

  Future<void> createPost({String content, String title, File file}) async{
    DateTime dateTime = DateTime.now();
    bool check = true;
    if(content == ""){
      check = false;
      emit(ValidatePost(null, 'Content cannot be blank'));
    }
    if(title == ""){
      check = false;
      emit(ValidatePost('Title cannot be blank', null));
    }
    if(check == true){
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('accessToken');
        String fileUrl;
        PostSave postSave;
        bool check;
        emit(CreatingPost());
        if(file == null){
          postSave = new PostSave(postDate: dateTime.toIso8601String(), title: title, text: content, link: null);
          check = await _postRepository.createPost(token, postSave);
          if (check == true) {
            emit(CreatePostSuccess(fileUrl));
          } else if (check == false) {
            emit(CreatePostError());
          }
        }else {
          await Firebase.initializeApp();
          Reference reference = FirebaseStorage.instance
              .ref()
              .child('audio_for_user_post')
              .child(basename(file.path) + '_' + DateTime.now().toString());

          UploadTask uploadTask = reference.putFile(file);
          uploadTask.whenComplete(() async {
            try {
              fileUrl = await reference.getDownloadURL();
              postSave = new PostSave(postDate: dateTime.toIso8601String(),
                  title: title,
                  text: content,
                  link: fileUrl);
              check = await _postRepository.createPost(token, postSave);
              if (check == true) {
                emit(CreatePostSuccess(fileUrl));
              } else if (check == false) {
                emit(CreatePostError());
              }
            } catch (onError) {
              print("Error");
            }
            print(fileUrl);
          });
        }
      } on Exception {
        emit(CreatePostError());
      }
    }
  }
}