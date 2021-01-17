import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

import '../constants.dart';

class ConversationProvider {
  final Dio _dio = Dio();
  HiveUtils _hiveUtils = new HiveUtils();

  Future<List<Conversation>> getConversationByLessonId(
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
        responseAPI = _hiveUtils.getBoxes('JSON', '${APIConstants.CONVERSATION}$lessonId');
      }else{
        bool exist =  _hiveUtils.isExists(name: '${APIConstants.CONVERSATION}$lessonId', boxName: 'JSON');
        Response response = await _dio.get('${APIConstants.CONVERSATION}$lessonId',
            options: Options(headers: header));
        responseAPI = new ResponseAPI(name: '${APIConstants.CONVERSATION}$lessonId', response: jsonEncode(response.data));
        if(exist){
          _hiveUtils.addBox(responseAPI, 'JSON');
        }else{
          _hiveUtils.addBox(responseAPI, 'JSON');
        }
      }
      return (jsonDecode(responseAPI.response) as List).map((i) => Conversation.fromJson(i)).toList();

    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Conversation>>  getConversationFromLocalStorage(String lessonId) async {
    List<Conversation> result;
    try{
      ResponseAPI responseAPI = _hiveUtils.getBoxes(HiveBoxName.JSON_BOX, '${APIConstants.CONVERSATION}$lessonId');
      if(responseAPI != null){
        result = (jsonDecode(responseAPI.response) as List).map((i) => Conversation.fromJson(i)).toList();
      }
    }catch(error, stacktrace){
      print("Exception occur: $error stackTrace: $stacktrace");
    }
    return result;
  }
}
