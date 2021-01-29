
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

import '../constants.dart';

class UserProvider{
  final Dio _dio = Dio();
  HiveUtils _hiveUtils = new HiveUtils();

  Future<LoginResponse> login(String username, String password) async{
    Map<String, String> headers = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': password,
      'username': username
    };
    try {
      Response response = await _dio.post(APIConstants.LOGIN, options: Options(headers: headers), data: json.encode(body));
      print(response.data);
      LoginResponse _loginResponse = LoginResponse.fromJson(response.data);
      return _loginResponse;
    } catch (error, stacktrace) {
      print("Exception occur: $error stackTrace: $stacktrace");
    }
  }

  Future<String> register(String username, String password, String email, String nation) async{
    String result = '';
    Map<String, String> headers = {
      "Content-type": "application/json"
    };
    Map<String, String> body = {
      'password': password,
      'username': username,
      "email" : email,
      'nation' : nation
    };
    try {
      Response response = await _dio.post(APIConstants.REGISTER, options: Options(headers: headers), data: json.encode(body));
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
      'Authorization': 'Bearer $token',
    };

    Map<String, String> query = {
      'username': username,
    };

    try {
      ResponseAPI responseAPI = new ResponseAPI();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none){
        responseAPI = _hiveUtils.getBoxes(HiveBoxName.JSON_BOX, APIConstants.GET_PROFILE);
      }else {
        bool exist = _hiveUtils.isExists(name: APIConstants.GET_PROFILE, boxName: 'JSON');
        Response response = await _dio.get(
            APIConstants.GET_PROFILE, options: Options(headers: headers),
            queryParameters: query);
        responseAPI = new ResponseAPI(name: APIConstants.GET_PROFILE, response: jsonEncode(response.data));
        if(exist){
          _hiveUtils.updateBox(responseAPI, HiveBoxName.JSON_BOX);
        }else{
          _hiveUtils.addBox(responseAPI, HiveBoxName.JSON_BOX);
        }
      }
      UserProfile userProfile = UserProfile.fromJson(jsonDecode(responseAPI.response));
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
      Response response = await _dio.post(APIConstants.SEND_EMAIL, options: Options(headers: headers), data: body);
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
      Response response = await _dio.put(APIConstants.CHANGE_PASSWORD, options: Options(headers: headers), data: body);
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
    Map<String, String> headers = {
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
      Response response = await _dio.post(APIConstants.LOGIN_GMAIL, options: Options(headers: headers), data: json.encode(body));
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
      Response response = await _dio.put(APIConstants.EDIT_PROFILE, options: Options(headers: headers), data: editUser.toJson());
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