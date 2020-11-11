import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';

class QuizProvider {
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String GETQUIZ = BASE_URL + "/api/quiz/";
  static final String GETQUESTIONS = BASE_URL + "/api/question/";
  final Dio _dio = new Dio();

  Future<List<Quiz>> getQuizByLessonId(String token, String lessonId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$GETQUIZ$lessonId', options: Options(headers: header));
      print(response.data.toString());
      return (response.data as List).map((i) => Quiz.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

  }

  Future<List<Question>> getQuestionsByQuizId(String token, int quizId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$GETQUESTIONS$quizId', options: Options(headers: header));
      print(response.data.toString());
      return (response.data as List).map((i) => Question.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}