import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';

class ConversationProvider {
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String CONVERSATION = BASE_URL + "/api/conversation/getByLesson/";
  final Dio _dio = Dio();

  Future<List<Conversation>> getConversationByLessonId(
      String lessonId, String token) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$CONVERSATION$lessonId',
          options: Options(headers: header));
      print(response.data.toString());
      return (response.data as List)
          .map((i) => Conversation.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
