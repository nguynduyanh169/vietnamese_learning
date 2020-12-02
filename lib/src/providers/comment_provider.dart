
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/comment.dart';


class CommentProvider{
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String GET_COMMENTS = BASE_URL + "/api/comment/";
  static final String CREATE_COMMENT = BASE_URL + "/api/comment";
  static final String DELETE_COMMENT = BASE_URL + "/api/comment";

  final Dio _dio = Dio();

  Future<List<Comment>> getCommentsByPostId(String token, int postId) async{
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get('$GET_COMMENTS$postId',
          options: Options(headers: header));
      return (response.data as List)
          .map((i) => Comment.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> saveComment(CommentSave comment, String token) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post(CREATE_COMMENT,
          options: Options(headers: headers), data: comment.toJson());
      if(response.data == 'Comment Success!!!'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> deleteComment(int commentId, String token) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.delete('$DELETE_COMMENT/$commentId',
          options: Options(headers: headers));
      if(response.data == 'Delete Success!!!'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

  }
}