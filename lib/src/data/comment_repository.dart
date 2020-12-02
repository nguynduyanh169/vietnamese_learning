import 'package:vietnamese_learning/src/models/comment.dart';
import 'package:vietnamese_learning/src/providers/comment_provider.dart';

class CommentRepository {
  CommentProvider _commentProvider = new CommentProvider();

  Future<List<Comment>> getCommentsByPostId(
      int postId, String token) {
    return _commentProvider.getCommentsByPostId(token, postId);
  }

  Future<bool> saveComment(CommentSave comment, String token){
    return _commentProvider.saveComment(comment, token);
  }

  Future<bool> deleteComment(int commentId, String token){
    return _commentProvider.deleteComment(commentId, token);
  }

}