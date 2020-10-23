import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';

class VocabularyProvider {
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String VOCABULARY = BASE_URL + "/api/vocabulary/";
  final Dio _dio = Dio();

  Future<List<Vocabulary>> getVocabularyByLessonId(
      String lessonId, String token) async {
    print(lessonId);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$VOCABULARY$lessonId', options: Options(headers: header));
      print(response.data.toString());
      return (response.data as List).map((i) => Vocabulary.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
