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
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        responseAPI = _hiveUtils.getBoxes(HiveBoxName.JSON_BOX, APIConstants.LESSONS_BY_LEVEL);
      }else{
        bool exist = await _hiveUtils.isExists(name: APIConstants.LESSONS_BY_LEVEL, boxName: HiveBoxName.JSON_BOX);
        Response response = await _dio.get(APIConstants.LESSONS_BY_LEVEL, options: Options(headers: headers));
        print(response.headers);
        responseAPI = new ResponseAPI(name: APIConstants.LESSONS_BY_LEVEL, response: jsonEncode(response.data));
        print(exist);
        if(exist){
          _hiveUtils.updateBox(responseAPI, HiveBoxName.JSON_BOX);
        }else{
          _hiveUtils.addBox(responseAPI, HiveBoxName.JSON_BOX);
          _hiveUtils.addBox(responseAPI, HiveBoxName.LOCAL_LESSON);
        }
      }
      return (jsonDecode(responseAPI.response) as List).map((i) => Lesson.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }

  Future<List<Lesson>> getLessonLocal() async{
    try{
      ResponseAPI responseAPI = new ResponseAPI();
      responseAPI = _hiveUtils.getBoxes(HiveBoxName.LOCAL_LESSON, APIConstants.LESSONS_BY_LEVEL);
      if(responseAPI != null){
        return  (jsonDecode(responseAPI.response) as List).map((i) => Lesson.fromJson(i)).toList();
      }
    }catch(error, stacktrace){
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Lesson>> getLessonLocalJson() async{
    try{
      ResponseAPI responseAPI = new ResponseAPI();
      responseAPI = _hiveUtils.getBoxes(HiveBoxName.JSON_BOX, APIConstants.LESSONS_BY_LEVEL);
      if(responseAPI != null){
        return  (jsonDecode(responseAPI.response) as List).map((i) => Lesson.fromJson(i)).toList();
      }
    }catch(error, stacktrace){
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }
}
