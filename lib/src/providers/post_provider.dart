import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/post.dart';

class PostProvider {
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String CREATE_POST = BASE_URL + "/api/post";
  Dio _dio = new Dio();

  Future<bool> createPost(String token, PostSave postSave) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    print(token);
    print(postSave.toJson());
    try {
      Response response = await _dio.post(CREATE_POST,
          options: Options(headers: headers), data: postSave.toJson());
      print(response.data);
      if(response.data == 'Create Success!!!'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
