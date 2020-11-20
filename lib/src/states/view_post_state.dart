import 'package:vietnamese_learning/src/models/comment.dart';

abstract class ViewPostState {
  const ViewPostState();
}

class InitialViewPost extends ViewPostState{
  const InitialViewPost();
}

class LoadPostSuccess extends ViewPostState{
  final List<Comment> comments;
  const LoadPostSuccess(this.comments);
}

class LoadingPost extends ViewPostState{
  const LoadingPost();
}

class LoadPostFailed extends ViewPostState{
  const LoadPostFailed();
}

class CommentPostSuccess extends ViewPostState{
  final List<Comment> comments;
  const CommentPostSuccess(this.comments);
}

class CommentPostInvalid extends ViewPostState{
  const CommentPostInvalid();
}

class CommentingPost extends ViewPostState{
  const CommentingPost();
}

class CommentPostFailed extends ViewPostState{
  const CommentPostFailed();
}