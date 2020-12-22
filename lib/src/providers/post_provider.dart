import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/post.dart';

class PostProvider {
  static final String BASE_URL = "https://master-vnam.azurewebsites.net";
  static final String CREATE_POST = BASE_URL + "/api/post";
  static final String GET_POST = BASE_URL + "/api/post";
  static final String GET_NEXT_POST = BASE_URL + "/api/post/nextPost";
  static final String GET_MY_POST = BASE_URL + "/api/post/myPost";
  static final String UPDATE_POST = BASE_URL + "/api/post";
  static final String DELETE_POST = BASE_URL + "/api/post";
  static final String SEARCH_POSTS = BASE_URL + "/api/post/search";
  Dio _dio = new Dio();

  Future<bool> createPost(String token, PostSave postSave) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      Response response = await _dio.post(CREATE_POST,
          options: Options(headers: headers), data: postSave.toJson());
      if (response.data == 'Create Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> updatePost(String token, PostUpdate postUpdate) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      Response response = await _dio.put(CREATE_POST,
          options: Options(headers: headers), data: postUpdate.toJson());
      if (response.data == 'Update Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

  }

  Future<bool> deletePostById(String token, int postId) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      print('deleting');
      Response response = await _dio.delete('$DELETE_POST/$postId',
          options: Options(headers: headers));
      if (response.data == 'Delete Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Post> loadInitPosts(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response =
          await _dio.get(GET_POST, options: Options(headers: headers));
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Content>> loadMyPosts(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      Response response =
      await _dio.get(GET_MY_POST, options: Options(headers: headers));
      return (response.data as List)
          .map((i) => Content.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

  }

  Future<Post> loadNextPosts(String token, Post currentPage) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.post(GET_NEXT_POST,
          options: Options(headers: headers), data: currentPage.toJson());
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Content>> searchPost(String token, String search) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response =
      await _dio.get('$SEARCH_POSTS/$search', options: Options(headers: headers));
      return (response.data as List)
          .map((i) => Content.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }

  }
}
