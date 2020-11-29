abstract class CreatePostState{
  const CreatePostState();
}

class Init extends CreatePostState{
  const Init();
}
class CreatingPost extends CreatePostState{
  const CreatingPost();
}

class CreatePostSuccess extends CreatePostState{
  final String fileUrl;
  const CreatePostSuccess(this.fileUrl);
}

class CreatePostError extends CreatePostState{
  const CreatePostError();
}
class ValidatePost extends CreatePostState{
  final String titleMessage;
  final String contentMessage;
  const ValidatePost(this.titleMessage, this.contentMessage);
}
