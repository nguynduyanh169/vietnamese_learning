import 'dart:core';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';

class EntranceQuizProvider{
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String ENTRANCE_QUIZ = BASE_URL + "/api/question";
  final Dio _dio = new Dio();

  Future<List<EntranceQuiz>> getEntranceQuiz() async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      Response response = await _dio.get(ENTRANCE_QUIZ, options: Options(headers: header));
      return (response.data as List).map((i) => EntranceQuiz.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}