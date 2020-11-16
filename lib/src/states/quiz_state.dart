import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';

abstract class QuizState {
  const QuizState();
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizLoaded extends QuizState {
  final Quiz quiz;
  final List<Question> questions;

  const QuizLoaded(this.quiz, this.questions);
}

class QuizLoadError extends QuizState {
  final String error;

  const QuizLoadError(this.error);
}
