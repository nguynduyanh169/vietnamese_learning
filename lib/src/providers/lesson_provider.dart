import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';

class LessonProvider {
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String LESSONSBYLEVEL = BASE_URL + "/api/lessons";
  Dio _dio = new Dio();

  Future<List<Lesson>> getLessonByLevel(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'student_token': '$token',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response =
          await _dio.get(LESSONSBYLEVEL, options: Options(headers: headers));
      print(response.data);
      return (response.data as List).map((i) => Lesson.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
