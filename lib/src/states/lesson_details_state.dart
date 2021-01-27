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
  final bool isSyncProgress;
  final bool isUpdated;
  const LoadLocalLessonSuccess(this.vocabularies, this.conversations, this.progressLocal, this.isSyncProgress, this.isUpdated);
}

class CannotLoadLocalLesson extends LessonDetailsState{
  final String message;
  final SaveProgressLocal progressLocal;
  final bool isSyncProgress;
  const CannotLoadLocalLesson(this.message, this.progressLocal, this.isSyncProgress);
}

class SyncingProgress extends LessonDetailsState{
  const SyncingProgress();
}

class SyncProgressSuccess extends LessonDetailsState{
  final SaveProgressLocal newProgressLocal;
  const SyncProgressSuccess(this.newProgressLocal);
}

class SyncProgressFailed extends LessonDetailsState{
  final String message;
  const SyncProgressFailed(this.message);
}
