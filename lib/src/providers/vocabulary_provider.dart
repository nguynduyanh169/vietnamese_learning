import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';

import '../constants.dart';

class VocabularyProvider {
  final Dio _dio = Dio();

  Future<List<Vocabulary>> getVocabularyByLessonId(
      String lessonId, String token) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('${APIConstants.VOCABULARY}$lessonId', options: Options(headers: header));
      print(response.data.toString());
      return (response.data as List).map((i) => Vocabulary.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
