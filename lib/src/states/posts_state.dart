import 'package:vietnamese_learning/src/models/post.dart';

abstract class PostsState{
  const PostsState();
}

class InitLoadPosts extends PostsState{
  const InitLoadPosts();
}

class LoadingPosts extends PostsState{
  const LoadingPosts();
}

class LoadPostsSuccess extends PostsState{
  final Post post;
  final List<Content> contents;
  const LoadPostsSuccess(this.contents, this.post);
}

class LoadPostsError extends PostsState{
  const LoadPostsError();
}

class LoadingMorePost extends PostsState{
  const LoadingMorePost();
}

class LoadMorePostSuccess extends PostsState{
  final Post post;
  final List<Content> contents;
  const LoadMorePostSuccess(this.contents, this.post);
}

class LoadMorePostError extends PostsState{
  const LoadMorePostError();
}