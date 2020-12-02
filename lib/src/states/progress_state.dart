import 'package:vietnamese_learning/src/models/entrance_quiz.dart';

abstract class ProgressState{
  const ProgressState();
}

class InitialCreateProgress extends ProgressState{
  const InitialCreateProgress();
}

class CreateProgressSuccess extends ProgressState{
  const CreateProgressSuccess();
}

class CreateProgressFail extends ProgressState{
  const CreateProgressFail();
}

class CreatingProgress extends ProgressState{
  const CreatingProgress();
}

class LoadingEntranceQuiz extends ProgressState{
  const LoadingEntranceQuiz();
}

class LoadedEntranceQuiz extends ProgressState{
  final List<EntranceQuiz> entranceQuizzes;
  const LoadedEntranceQuiz(this.entranceQuizzes);
}

class LoadEntranceQuizFailed extends ProgressState{
  const LoadEntranceQuizFailed();
}