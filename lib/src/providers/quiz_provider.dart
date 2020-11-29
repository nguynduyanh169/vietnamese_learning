import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/models/question.dart';
import 'package:vietnamese_learning/src/models/quiz.dart';
import 'package:vietnamese_learning/src/models/quiz_submit.dart';

class QuizProvider {
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String GETQUIZ = BASE_URL + "/api/quiz/";
  static final String GETQUESTIONS = BASE_URL + "/api/question/";
  static final String SUBMITQUIZ = BASE_URL + "/api/history";
  final Dio _dio = new Dio();

  Future<Quiz> getQuizByLessonId(String token, String lessonId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$GETQUIZ$lessonId', options: Options(headers: header));
      Quiz quiz = Quiz.fromJson(response.data);
      return quiz;
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
      return (response.data as List).map((i) => Question.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> submitQuiz(String token, QuizSubmit quizSubmit) async{
    print(token);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post(SUBMITQUIZ, options: Options(headers: header), data: quizSubmit.toJson());
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