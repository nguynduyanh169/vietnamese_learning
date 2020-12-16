import 'package:vietnamese_learning/src/models/comment.dart';

abstract class ViewPostState {
  const ViewPostState();
}

class InitialViewPost extends ViewPostState{
  const InitialViewPost();
}

class LoadPostSuccess extends ViewPostState{
  final List<Comment> comments;
  final String owner;
  const LoadPostSuccess(this.comments, this.owner);
}

class LoadingPost extends ViewPostState{
  const LoadingPost();
}

class LoadPostFailed extends ViewPostState{
  final String owner;
  const LoadPostFailed(this.owner);
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

class DeletingPost extends ViewPostState{
  const DeletingPost();
}

class DeletePostSuccess extends ViewPostState{
  const DeletePostSuccess();
}

class DeletePostFailed extends ViewPostState{
  const DeletePostFailed();
}

class DeletingComent extends ViewPostState{
  const DeletingComent();
}

class DeleteCommentSuccess extends ViewPostState{
  final List<Comment> comments;
  const DeleteCommentSuccess(this.comments);
}

class DeleteCommentFailed extends ViewPostState{
  const DeleteCommentFailed();
}
