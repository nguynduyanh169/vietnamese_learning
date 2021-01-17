import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/states/profile_state.dart';
import 'package:vietnamese_learning/src/utils/firebase_util.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class ProfileCubit extends Cubit<ProfileState>{

  ProfileCubit(): super(Initial());

  Future<void> logout(String username) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    HiveUtils _hiveUtils = new HiveUtils();
    emit(LoggingOut());
    try{
      prefs.remove('username');
      prefs.remove('accessToken');
      prefs.remove(username + 'profile');
      prefs.remove(username  + "SearchHistory");
      prefs.remove(username + 'schedule');
      signOutUser();
      List<String> filePaths = _hiveUtils.getAllFiles('CacheFile');
      for(String item in filePaths){
        final dir = Directory(item);
        dir.deleteSync(recursive: true);
      }
      _hiveUtils.deleteBox('JSON');
      _hiveUtils.deleteBox('CacheFile');
      emit(LogoutSuccess());
    }on Exception catch(e){
      print(e.toString());
      emit(LogoutFailed('Logout Failed!'));
    }
  }
}