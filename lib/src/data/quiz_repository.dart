import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';
import 'package:vietnamese_learning/src/models/quiz_submit.dart';
import 'package:vietnamese_learning/src/providers/quiz_provider.dart';

class QuizRepository {
  QuizProvider _quizProvider = new QuizProvider();

  Future<Quiz> getQuizByLessonId(String token, String lessonId) {
    return _quizProvider.getQuizByLessonId(token, lessonId);
  }

  Future<List<Question>> getQuestionsByQuizId(String token, int quizId) {
    return _quizProvider.getQuestionsByQuizId(token, quizId);
  }

  Future<bool> submitQuiz(String token, QuizSubmit quizSubmit){
    return _quizProvider.submitQuiz(token, quizSubmit);
  }
}