import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/models/vocabulary.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

import '../constants.dart';

class VocabularyProvider {
  final Dio _dio = Dio();
  HiveUtils _hiveUtils = new HiveUtils();

  Future<List<Vocabulary>> getVocabularyByLessonId(
      String lessonId, String token) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      ResponseAPI responseAPI = new ResponseAPI();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        responseAPI = _hiveUtils.getBoxes('JSON', '${APIConstants.VOCABULARY}$lessonId');
      }else{
        bool exist =  _hiveUtils.isExists(name: '${APIConstants.VOCABULARY}$lessonId', boxName: 'JSON');
        Response response = await _dio.get('${APIConstants.VOCABULARY}$lessonId', options: Options(headers: header));
        responseAPI = new ResponseAPI(name: '${APIConstants.VOCABULARY}$lessonId', response: jsonEncode(response.data));
        if(exist){
          _hiveUtils.addBox(responseAPI, 'JSON');
        }else{
          _hiveUtils.addBox(responseAPI, 'JSON');
        }
      }
      return (jsonDecode(responseAPI.response) as List).map((i) => Vocabulary.fromJson(i)).toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }
}
