import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/conversation.dart';

import '../constants.dart';

class ConversationProvider {
  final Dio _dio = Dio();

  Future<List<Conversation>> getConversationByLessonId(
      String lessonId, String token) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('${APIConstants.CONVERSATION}$lessonId',
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
