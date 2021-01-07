import 'dart:core';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';

import '../constants.dart';

class EntranceQuizProvider{
  final Dio _dio = new Dio();

  Future<List<EntranceQuiz>> getEntranceQuiz() async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      Response response = await _dio.get(APIConstants.ENTRANCE_QUIZ, options: Options(headers: header));
      return (response.data as List).map((i) => EntranceQuiz.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}