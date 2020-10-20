
import 'dart:convert';

import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/utils/network_utils.dart';

class UserRepository {

  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://vn-learning.azurewebsites.net";
  static final LOGIN_URL = BASE_URL + "/api/authen/login";

  Future<LoginResponse> login(String username, String password) {
    var userHeader = {"Content-type": "application/json"};
    return _netUtil.post(LOGIN_URL,headers: userHeader, body: json.encode({"username": '$username', "password": '$password'})).then((dynamic res) {
      LoginResponse response = new LoginResponse.fromJson(res);
      print(response.toString());
      if(response.tokenType == 'Fail'){
        throw new Exception('Login Fail');
      }
      else {
        print("successful");
        return new LoginResponse.fromJson(res);
      }
    });
  }
}