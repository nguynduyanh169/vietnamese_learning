import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/providers/post_provider.dart';

class PostRepository{
  PostProvider _postProvider = new PostProvider();

  Future<bool> createPost(String token, PostSave postSave){
    return _postProvider.createPost(token, postSave);
  }
}