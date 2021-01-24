
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class LessonsCubit extends Cubit<LessonsState>{
  final LessonRepository _lessonRepository;
  UserRepository _userRepository;
  HiveUtils _hiveUtils;

  LessonsCubit(this._lessonRepository) : super(LessonsLoading());

  Future<void> loadLessonByLevel() async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      String username = prefs.getString('username');
      _userRepository = new UserRepository();
      _hiveUtils = new HiveUtils();
      UserProfile userProfile = await _userRepository.getUserProfile(token, username);
      prefs.setString(username + 'profile', json.encode(userProfile));
      bool avatarExist = _hiveUtils.fileExist(url: userProfile.avatar, boxName: 'CacheFile');
      if(!avatarExist){
        if(userProfile.avatar != null){
          print(userProfile.avatar);
          String filePath  = await _hiveUtils.downloadFile(userProfile.avatar);
          _hiveUtils.addFile(filePath: filePath, url: userProfile.avatar, boxName: 'CacheFile');
        }
      }
      List<Lesson> listLessons = await _lessonRepository.getLessonsByLevelId(token);
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult != ConnectivityResult.none){
        for(Lesson lesson in listLessons){
          bool fileExist = _hiveUtils.fileExist(url: lesson.lessonImage, boxName: 'CacheFile');
          if(!fileExist){
            String filePath = await _hiveUtils.downloadFile(lesson.lessonImage);
            _hiveUtils.addFile(filePath: filePath, url: lesson.lessonImage, boxName: 'CacheFile');
          }
        }
      }
      emit(LessonsLoaded(listLessons, userProfile));
    } on Exception{
      emit(LessonLoadError('Load Lesson Error'));
    }
  }

  Future<void> reloadLessons() async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Lesson> listLessons = await _lessonRepository.getLessonsByLevelId(token);
      var connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult != ConnectivityResult.none){
        for(Lesson lesson in listLessons){
          bool fileExist = _hiveUtils.fileExist(url: lesson.lessonImage, boxName: 'CacheFile');
          if(!fileExist){
            String filePath = await _hiveUtils.downloadFile(lesson.lessonImage);
            _hiveUtils.addFile(filePath: filePath, url: lesson.lessonImage, boxName: 'CacheFile');
          }
        }
      }
      emit(ReloadLessonsSuccess(listLessons));
    }on Exception{
      emit(LessonLoadError('LoadLessonError'));
    }
  }

}