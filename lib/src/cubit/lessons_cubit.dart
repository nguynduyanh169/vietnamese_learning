
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/states/lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState>{
  final LessonRepository _lessonRepository;

  LessonsCubit(this._lessonRepository) : super(LessonsLoading());

  Future<void> loadLessonByLevel() async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      List<Lesson> listLessons = await _lessonRepository.getLessonsByLevelId(token);
      emit(LessonsLoaded(listLessons));
    } on Exception{
      emit(LessonLoadError('Load Lesson Error'));
    }
  }

}