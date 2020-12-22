import "package:dio/dio.dart";
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/models/memory_model.dart';

class GameProvider{
  static final String BASE_URL = "https://master-vnam.azurewebsites.net";
  static final String GAME = BASE_URL + "/api/vocabulary/loadGame/";
  final Dio _dio = Dio();

  Future<List<TileModel>> getVocabularyByLevel(int levelID, String token) async{

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try{
      Response response = await _dio.get('$GAME$levelID', options: Options(headers: header));
      print(response.data.toString());
      return(response.data as List).map((i) => TileModel.fromJson(i)).toList();
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}