import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

import '../constants.dart';

class LessonProvider {
  Dio _dio = new Dio();
  HiveUtils _hiveUtils = new HiveUtils();

  Future<List<Lesson>> getLessonByLevel(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'studentToken': '$token',
      'Authorization': 'Bearer $token'
    };
    try {
      ResponseAPI responseAPI = new ResponseAPI();
      //bool exist = await _hiveUtils.isExists(boxName: 'LessonByLevel');
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        responseAPI = await _hiveUtils.getBoxes('LessonByLevel', APIConstants.LESSONS_BY_LEVEL);
      }else{
        Response response = await _dio.get(APIConstants.LESSONS_BY_LEVEL, options: Options(headers: headers));
        //Response response = await _dioUtils.get(url: APIConstants.LESSONS_BY_LEVEL, options: buildServiceCacheOptions(options: Options(headers: headers)));
        responseAPI = new ResponseAPI(name: APIConstants.LESSONS_BY_LEVEL, response: jsonEncode(response.data));
        await _hiveUtils.addBox(responseAPI, 'LessonByLevel');
      }
      return (jsonDecode(responseAPI.response) as List).map((i) => Lesson.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }
}
