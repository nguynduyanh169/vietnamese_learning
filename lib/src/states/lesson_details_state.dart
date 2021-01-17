import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';

abstract class LessonDetailsState{
  const LessonDetailsState();
}

class InitialState extends LessonDetailsState{
  const InitialState();
}

class DownloadingLesson extends LessonDetailsState{
  final double percent;
  const DownloadingLesson(this.percent);
}

class DownloadLessonSuccess extends LessonDetailsState{
  final List<Vocabulary> vocabularies;
  final List<Conversation> conversations;
  const DownloadLessonSuccess(this.vocabularies, this.conversations);
}

class DownloadLessonFailed extends LessonDetailsState{
  final String message;
  const DownloadLessonFailed(this.message);
}

class LoadingLocalLesson extends LessonDetailsState{
  const LoadingLocalLesson();
}

class LoadLocalLessonSuccess extends LessonDetailsState{
  final List<Vocabulary> vocabularies;
  final List<Conversation> conversations;
  final SaveProgressLocal progressLocal;
  const LoadLocalLessonSuccess(this.vocabularies, this.conversations, this.progressLocal);
}

class CannotLoadLocalLesson extends LessonDetailsState{
  final String message;
  const CannotLoadLocalLesson(this.message);
}