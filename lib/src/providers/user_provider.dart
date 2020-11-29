
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';

class UserProvider{
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String LOGIN = BASE_URL + "/api/authen/login";
  static final String REGISTER = BASE_URL + "/api/authen/signup";
  final Dio _dio = Dio();

  Future<LoginResponse> login(String username, String password) async{
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': password,
      'username': username
    };
    try {
      Response response = await _dio.post(LOGIN, options: Options(headers: header), data: json.encode(body));
      print(response.data);
      LoginResponse _loginResponse = LoginResponse.fromJson(response.data);
      return _loginResponse;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<LoginResponse> register(String username, String password, String email) async{
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': password,
      'username': username,
      "email" : email,
    };
    try {
      Response response = await _dio.post(REGISTER, options: Options(headers: header), data: json.encode(body));
      print(response.data);
      LoginResponse _loginResponse = LoginResponse.fromJson(response.data);
      return _loginResponse;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

}