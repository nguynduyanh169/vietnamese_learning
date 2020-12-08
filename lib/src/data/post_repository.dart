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

  Future<List<Content>> loadMyPosts(String token){
    return _postProvider.loadMyPosts(token);
  }

  Future<bool> deletePost(String token, int postId){
    return _postProvider.deletePostById(token, postId);
  }

  Future<bool> editPost(String token, PostUpdate postUpdate){
    return _postProvider.updatePost(token, postUpdate);
  }

  Future<List<Content>> searchPosts(String token, String search){
    return _postProvider.searchPost(token, search);
  }
}