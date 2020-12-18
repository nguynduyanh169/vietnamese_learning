
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState>{
  final LessonRepository _lessonRepository;
  UserRepository _userRepository;

  LessonsCubit(this._lessonRepository) : super(LessonsLoading());

  Future<void> loadLessonByLevel() async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      String username = prefs.getString('username');
      _userRepository = new UserRepository();
      UserProfile userProfile = await _userRepository.getUserProfile(token, username);
      print(userProfile.username);
      print('user');
      prefs.setString(username + 'profile', json.encode(userProfile));
      List<Lesson> listLessons = await _lessonRepository.getLessonsByLevelId(token);
      emit(LessonsLoaded(listLessons, userProfile));
    } on Exception{
      emit(LessonLoadError('Load Lesson Error'));
    }
  }

}