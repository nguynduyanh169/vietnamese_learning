
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/comment.dart';

import '../constants.dart';


class CommentProvider{
  final Dio _dio = Dio();

  Future<List<Comment>> getCommentsByPostId(String token, int postId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('${APIConstants.GET_COMMENTS}$postId',
          options: Options(headers: header));
      return (response.data as List)
          .map((i) => Comment.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> saveComment(CommentSave comment, String token) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post(APIConstants.CREATE_COMMENT,
          options: Options(headers: headers), data: comment.toJson());
      if(response.data == 'Comment Success!!!'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> deleteComment(int commentId, String token) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.delete('${APIConstants.DELETE_COMMENT}/$commentId',
          options: Options(headers: headers));
      if(response.statusCode == 200) {
        if (response.data == 'Delete Success!!!') {
          return true;
        } else {
          return false;
        }
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }
}