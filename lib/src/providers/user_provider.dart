
import 'package:dio/dio.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';

class UserProvider{
  static final String BASE_URL = "https://vn-learning.azurewebsites.net";
  static final String LOGIN = BASE_URL + "/api/vocabulary/";
  final Dio _dio = Dio();

  Future<LoginResponse> login(String username, String password) async{
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    try {
      Response response = await _dio.get(LOGIN, options: Options(headers: header));
      LoginResponse _loginResponse = LoginResponse.fromJson(response.data);
      if(_loginResponse.tokenType == 'Fail'){
        throw new Exception('Login Fail');
      }else{
        print('Login successful!');
        return _loginResponse;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

}