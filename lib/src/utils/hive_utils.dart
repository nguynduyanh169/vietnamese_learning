import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vietnamese_learning/src/models/response_api.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';

class HiveUtils {
  isExists({String name, String boxName}) {
    ResponseAPI responseAPI;
    final openBox = Hive.box(boxName);
    responseAPI = openBox.get(name);
    return responseAPI != null;
  }

  isProgressExist({String lessonID, String boxName}){
    SaveProgressLocal progressLocal;
    final openBox = Hive.box(boxName);
    progressLocal = openBox.get(lessonID);
    return progressLocal != null;
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

  addLesson(ResponseAPI responseAPI, String boxName) {
    final openBox = Hive.box(boxName);
    openBox.put(responseAPI.name, responseAPI);
  }

  addProgress({SaveProgressLocal progressLocal, String boxName}){
    final openBox = Hive.box(boxName);
    openBox.put(progressLocal.lessonID, progressLocal);
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

  updateLocalProgress({SaveProgressLocal progressLocal, String boxName}){
    final openBox = Hive.box(boxName);
    for (int i = 0; i < openBox.length; i++) {
      SaveProgressLocal foundProgress = openBox.getAt(i);
      if (progressLocal.lessonID == foundProgress.lessonID) {
        openBox.putAt(i, progressLocal);
      }
    }
  }

  ResponseAPI getBoxes(String boxName, String name) {
    ResponseAPI responseAPI;
    final openBox = Hive.box(boxName);
    responseAPI = openBox.get(name);
    return responseAPI;
  }

  SaveProgressLocal getLocalProgress({String boxName, String lessonId}){
    print(lessonId);
    SaveProgressLocal progressLocal;
    final openBox = Hive.box(boxName);
    progressLocal = openBox.get(lessonId);
    return progressLocal;
  }

  List<String> getAllFiles(String boxName){
    List<String> result = new List<String>();
    final openBox = Hive.box(boxName);
    for (int i = 0; i < openBox.length; i++) {
      result.add(openBox.getAt(i));
    }
    return result;
  }

  deleteBox(String boxName) {
    Hive.box(boxName).clear();
  }

  Future<String> downloadFile(String url) async {
    String filePath;
    print(url);
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    if(url.contains('.mp3')){
      filePath = '$dir/${DateTime.now().toIso8601String()}.mp3';
    }else{
      filePath = '$dir/${DateTime.now().toIso8601String()}.png';
    }
    File file = new File(filePath);
    await file.writeAsBytes(bytes);
    return file.path;
  }

  deleteValue(String boxName, String url){
    final openBox = Hive.box(boxName);
    openBox.delete(url);
  }
}
