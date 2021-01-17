import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';
import 'package:vietnamese_learning/src/models/quiz_submit.dart';

import '../constants.dart';

class QuizProvider {
  final Dio _dio = new Dio();

  Future<Quiz> getQuizByLessonId(String token, String lessonId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('${APIConstants.GET_QUIZ}$lessonId', options: Options(headers: header));
      print(response.data);
      Quiz quiz = Quiz.fromJson(response.data);
      return quiz;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }

  Future<List<Question>> getQuestionsByQuizId(String token, String lessonID) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('${APIConstants.GET_QUESTIONS}$lessonID', options: Options(headers: header));
      return (response.data as List).map((i) => Question.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> submitQuiz(String token, QuizSubmit quizSubmit) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post(APIConstants.SUBMIT_QUIZ, options: Options(headers: header), data: quizSubmit.toJson());
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

}