import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';

class MyPostsCubit extends Cubit<PostsState>{
  PostRepository _postRepository;
  MyPostsCubit(this._postRepository): super(InitLoadPosts());
  Future<void> loadMyPosts() async{
    try{
      emit(LoadingMyPosts());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      String username = prefs.getString('username');
      List<Content> myPosts = await _postRepository.loadMyPosts(token);
      if(myPosts.length == 0){
        emit(LoadMyPostsError());
      }
      else{
        emit(LoadMyPostsSuccess(myPosts));
      }
    } on Exception{
      emit(LoadMyPostsError());
    }
  }
}