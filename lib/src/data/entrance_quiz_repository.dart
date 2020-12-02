import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/providers/entrance_quiz_provider.dart';

class EntranceQuizRepository{
  EntranceQuizProvider _entranceQuizProvider = new EntranceQuizProvider();

  Future<List<EntranceQuiz>> getEntranceQuiz(){
    return _entranceQuizProvider.getEntranceQuiz();
  }
}