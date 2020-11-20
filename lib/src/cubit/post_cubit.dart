import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/comment_repository.dart';
import 'package:vietnamese_learning/src/models/comment.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';
import 'package:vietnamese_learning/src/states/view_post_state.dart';

class PostCubit extends Cubit<ViewPostState>{
  CommentRepository _commentRepository;

  PostCubit(this._commentRepository): super(InitialViewPost());

  Future<void> loadComments(int postId) async{
    try{
      emit(LoadingPost());
      print('comment');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Comment> comments = await _commentRepository.getCommentsByPostId(postId, token);
      if(comments.isNotEmpty){
        emit(LoadPostSuccess(comments));
      }else{
        emit(LoadPostFailed());
      }
    } on Exception{
      emit(LoadPostFailed());
    }
  }

  Future<void> saveComment(CommentSave comment) async{
    try{
      emit(CommentingPost());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check = await _commentRepository.saveComment(comment, token);
      if(check == true){
        List<Comment> comments = await _commentRepository.getCommentsByPostId(comment.postId, token);
        emit(CommentPostSuccess(comments));
      }else{
        emit(CommentPostFailed());
      }
    }on Exception{
      emit(CommentPostFailed());
    }
  }
}
