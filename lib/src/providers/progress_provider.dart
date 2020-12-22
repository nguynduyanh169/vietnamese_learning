import 'package:dio/dio.dart';

class ProgressProvider {
  static final String BASE_URL = "https://master-vnam.azurewebsites.net";
  static final String CREATE_PROCESS =  BASE_URL + "/api/progress/createProgress";
  Dio _dio = new Dio();

  Future<bool> createProgress(int levelId, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'studentToken' : '$token'
    };
    try {
      print(headers);
      Response response = await _dio.post("$CREATE_PROCESS/$levelId",
          options: Options(headers: headers));
      print(response.data);
      if(response.data == 'redirect:/api/lesson/'){
        return true;
      }else{
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}