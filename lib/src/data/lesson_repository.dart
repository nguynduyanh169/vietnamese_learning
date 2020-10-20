
import 'dart:convert';

import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/utils/network_utils.dart';

class LessonRepository{
  NetworkUtil _networkUtil = new NetworkUtil();
  static final BASE_URL = 'https://vn-learning.azurewebsites.net';
  static final LESSON_URI = BASE_URL + '';

  Future<Lesson> getLessonsByLevelId(int levelId, String token){
    var lessonHeader = {"Content-type": "application/json", "studentToken": token};
    return _networkUtil.post(LESSON_URI,headers: lessonHeader, body: json.encode({'levelId': levelId})).then((dynamic res) {
      Lesson response = new Lesson.fromJson(res);
      print(response.toString());
        return new Lesson.fromJson(res);
    });
  }
}