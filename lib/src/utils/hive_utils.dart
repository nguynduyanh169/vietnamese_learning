import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';

class HiveUtils{
  isExists({String boxName}) async {
    print(boxName);
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    print("length :" + length.toString());
    return length != 0;
  }

  addBox(ResponseAPI responseAPI, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.add(responseAPI);
  }

  Future<ResponseAPI> getBoxes(String boxName, String name) async {
    ResponseAPI response = new ResponseAPI();
    final openBox = await Hive.openBox(boxName);
    for(int i = 0; i < openBox.length; i++){
      response = openBox.getAt(i);
      if(response.name == name){
        return response;
      }else{
        return null;
      }
    }
  }

}