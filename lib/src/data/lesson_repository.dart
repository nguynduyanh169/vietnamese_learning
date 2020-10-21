import 'dart:io';

import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/utils/network_utils.dart';

class LessonRepository {
  NetworkUtil _networkUtil = new NetworkUtil();
  static final BASE_URL = 'https://vn-learning.azurewebsites.net';
  static final LESSONS_URI = BASE_URL + '/api/lessons';

  Future<List<Lesson>> getLessonsByLevelId(String token) {
    var lessons = new List<Lesson>();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'student_token': "$token",
      HttpHeaders.authorizationHeader: 'Bearer $token'

    };
    return _networkUtil
        .getList(LESSONS_URI, header: headers)
        .then((List<dynamic> res) {
      lessons = res.map((i) => Lesson.fromJson(i)).toList();
      if (lessons == null) {
        throw new Exception('Lessons not found');
      } else {
        print('Lesson successful!');
        return lessons;
      }
    });
  }
}
