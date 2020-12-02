abstract class EditPostState {
  const EditPostState();
}

class InitialEditPost extends EditPostState{
  const InitialEditPost();
}

class EditingPost extends EditPostState{
  const EditingPost();
}

class EditPostSuccess extends EditPostState{
  const EditPostSuccess();
}

class EditPostFailed extends EditPostState{
  const EditPostFailed();
}

