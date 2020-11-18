import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/states/posts_state.dart';

class PostsCubit extends Cubit<PostsState>{
  PostRepository _postRepository;

  PostsCubit(this._postRepository): super(InitLoadPosts());

  Future<void> loadInitPost() async{
    try{
      emit(LoadingPosts());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      Post post = await _postRepository.loadInitPosts(token);
      print(post.toJson());
      List<Content> contents = post.content;
      if(contents.length == 0){
        emit(LoadPostsError());
      }else{
        emit(LoadPostsSuccess(contents, post));
      }
    } on Exception{
      emit(LoadPostsError());
    }
  }

  Future<void> loadMorePost(Post currentPage, int countPage, int totalPage) async{
    try{
      emit(LoadingMorePost());
      if(countPage >= totalPage - 1){
        emit(LoadMorePostDone());
      }else {
        countPage = countPage + 1;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('accessToken');
        Post post = await _postRepository.loadNextPosts(token, currentPage);
        List<Content> addContents = post.content;
        emit(LoadMorePostSuccess(addContents, post, countPage));
      }
    } on Exception{
      emit(LoadPostsError());
    }
  }
}