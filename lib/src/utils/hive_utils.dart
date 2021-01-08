import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';

class HiveUtils {
  isExists({String name, String boxName}) {
    ResponseAPI responseAPI;
    final openBox = Hive.box(boxName);
    responseAPI = openBox.get(name);
    return responseAPI != null;
  }

  fileExist({String url, String boxName}){
    if(url == null){
      return false;
    }else {
      final openBox = Hive.box(boxName);
      String filePath = openBox.get(url);
      return filePath != null;
    }
  }


  addBox(ResponseAPI responseAPI, String boxName) {
    final openBox = Hive.box(boxName);
    openBox.put(responseAPI.name, responseAPI);
  }

  addFile({String filePath, String url, String boxName}) {
    final openBox = Hive.box(boxName);
    openBox.put(url, filePath);
  }

  String getFile({String boxName, String url}) {
    final openBox = Hive.box(boxName);
    String filePath = openBox.get(url);
    return filePath;
  }

  updateBox(ResponseAPI responseAPI, String boxName) {
    final openBox = Hive.box(boxName);
    for (int i = 0; i < openBox.length; i++) {
      ResponseAPI foundResponse = openBox.getAt(i);
      if (responseAPI.name == foundResponse.name) {
        openBox.putAt(i, responseAPI);
      }
    }
  }

  ResponseAPI getBoxes(String boxName, String name) {
    ResponseAPI responseAPI;
    final openBox = Hive.box(boxName);
    responseAPI = openBox.get(name);
    return responseAPI;
  }

  deleteBox(String boxName) {
    Hive.box(boxName).clear();
  }

  Future<String> downloadFile(String url) async {
    var httpClient = new HttpClient();
    print(url);
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/${DateTime.now().toIso8601String()}');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
