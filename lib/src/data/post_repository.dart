import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/providers/post_provider.dart';

class PostRepository{
  PostProvider _postProvider = new PostProvider();

  Future<bool> createPost(String token, PostSave postSave){
    return _postProvider.createPost(token, postSave);
  }

  Future<Post> loadInitPosts(String token){
    return _postProvider.loadInitPosts(token);
  }

  Future<Post> loadNextPosts(String token, Post currentPage){
    return _postProvider.loadNextPosts(token, currentPage);
  }

  Future<List<MyPost>> loadMyPosts(String token){
    return _postProvider.loadMyPosts(token);
  }

}