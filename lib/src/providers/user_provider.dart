
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';

class UserProvider{
  static final String BASE_URL = "https://vn-master.azurewebsites.net";
  static final String LOGIN = BASE_URL + "/api/authen/login";
  static final String REGISTER = BASE_URL + "/api/authen/signup";
  static final String GET_PROFILE = BASE_URL + "/api/authen/getUserDetail";
  static final String SEND_EMAIL = BASE_URL + "/api/authen/forget";
  static final String CHANGE_PASSWORD = BASE_URL + "/api/authen/updateNewPassword";
  static final String LOGIN_GMAIL = BASE_URL + "/api/authen/signin-gmail";
  static final String EDIT_PROFILE = BASE_URL + "/api/authen/editProfile";
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

  Future<String> register(String username, String password, String email, String nation) async{
    String result = '';
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': password,
      'username': username,
      "email" : email,
      'nation' : nation
    };
    try {
      Response response = await _dio.post(REGISTER, options: Options(headers: header), data: json.encode(body));
      if(response.statusCode == 200){
        LoginResponse _loginResponse = LoginResponse.fromJson(response.data);
        result = "success!";
      }else{
        result = response.data;
      }
      return result;
    } catch (error, stacktrace) {
      if(error.toString().contains('412')){
        result = 'Account duplicate!';
        return result;
      }
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<UserProfile> getUserProfile(String token, String username) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map<String, String> query = {
      'username': username,
    };

    try {
      Response response = await _dio.get(GET_PROFILE, options: Options(headers: headers), queryParameters: query);
      UserProfile userProfile = UserProfile.fromJson(response.data);
      return userProfile;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<String> getCode(String email) async{
    Map<String, String> headers = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': null,
      'username': null,
      "email" : email,
      'nation' : null
    };
    try {
      Response response = await _dio.post(SEND_EMAIL, options: Options(headers: headers), data: body);
      String result = response.data;
      return result;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> changePassword(String email, String newPassword) async{
    Map<String, String> headers = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': newPassword,
      'username': null,
      "email" : email,
      'nation' : null
    };
    try {
      Response response = await _dio.put(CHANGE_PASSWORD, options: Options(headers: headers), data: body);
      String result = response.data;
      if(result == 'Update success'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }


  }

  Future<LoginResponse> signinGmail(String email, String fullname, String uid, String avatar, String username) async{
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'avatarLink': avatar,
      'email': email,
      'fullname': fullname,
      'uid': uid,
      'username': username
    };
    try{
      Response response = await _dio.post(LOGIN_GMAIL, options: Options(headers: header), data: json.encode(body));
      print(response.data);
      LoginResponse jwtToken = LoginResponse.fromJson(response.data);
      return jwtToken;
    }catch(error, stacktrace){
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> editProfile(String token, EditUser editUser) async{
    Map<String, String> headers = {
      'Content-Type': 'application/json;',
      'Authorization': 'Bearer $token'
    };
    try{
      Response response = await _dio.put(EDIT_PROFILE, options: Options(headers: headers), data: editUser.toJson());
      print(response.data);
      if(response.statusCode == 200){
        if(response.data == 'Update success'){
          return true;
        }else{
          return false;
        }
      }else if(response.statusCode == 500){
        return false;
      }
    }catch(error, stacktrace){
      print("Exception occur: $error stackTrace: $stacktrace");
    }

  }
}