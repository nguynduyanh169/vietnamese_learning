import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/post.dart';

class PostProvider {
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String CREATE_POST = BASE_URL + "/api/post";
  static final String GET_POST = BASE_URL + "/api/post";
  static final String GET_NEXT_POST = BASE_URL + "/api/post/nextPost";
  Dio _dio = new Dio();

  Future<bool> createPost(String token, PostSave postSave) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      Response response = await _dio.post(CREATE_POST,
          options: Options(headers: headers), data: postSave.toJson());
      if(response.data == 'Create Success!!!'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Post> loadInitPosts(String token) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.get(GET_POST, options: Options(headers: headers));
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Post> loadNextPosts(String token, Post currentPage) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.post(GET_NEXT_POST, options: Options(headers: headers), data: currentPage.toJson());
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

  }

}
