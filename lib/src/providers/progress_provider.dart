import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/sync_progress.dart';

import '../constants.dart';

class ProgressProvider {
  Dio _dio = new Dio();

  Future<bool> createProgress(int levelId, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post("${APIConstants.CREATE_PROCESS}/$levelId",
          options: Options(headers: headers));
      if(response.data == 'redirect:/api/lesson/'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<Progress> syncProgress(String token, Progress progress) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Response response = await _dio.post("${APIConstants.SYNC_PROGRESS}",
          options: Options(headers: headers), data: progress.toJson());
      if(response.statusCode == 200){
        return Progress.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

}