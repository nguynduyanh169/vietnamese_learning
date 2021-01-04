import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/post.dart';

import '../constants.dart';

class PostProvider {
  Dio _dio = new Dio();

  Future<bool> createPost(String token, PostSave postSave) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      Response response = await _dio.post(APIConstants.CREATE_POST,
          options: Options(headers: headers), data: postSave.toJson());
      if (response.data == 'Create Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> updatePost(String token, PostUpdate postUpdate) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken': '$token'
    };
    try {
      Response response = await _dio.put(APIConstants.UPDATE_POST,
          options: Options(headers: headers), data: postUpdate.toJson());
      if (response.data == 'Update Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
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
      Response response = await _dio.delete('${APIConstants.DELETE_POST}/$postId',
          options: Options(headers: headers));
      if (response.data == 'Delete Success!!!') {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
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
          await _dio.get(APIConstants.GET_POST, options: Options(headers: headers));
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
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
      await _dio.get(APIConstants.GET_MY_POST, options: Options(headers: headers));
      return (response.data as List)
          .map((i) => Content.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }

  Future<Post> loadNextPosts(String token, Post currentPage) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await _dio.post(APIConstants.GET_NEXT_POST,
          options: Options(headers: headers), data: currentPage.toJson());
      Post post = Post.fromJson(response.data);
      return post;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
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
      await _dio.get('${APIConstants.SEARCH_POSTS}/$search', options: Options(headers: headers));
      return (response.data as List)
          .map((i) => Content.fromJson(i))
          .toList();
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }
}
