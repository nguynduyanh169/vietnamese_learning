import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/lesson_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';

abstract class HomeScreenContract {
  void onLoadLessonSuccess(List<Lesson> listLessons);

  void onLoadLessonError(String errorText);
}

class HomeScreenPresenter {
  HomeScreenContract _view;
  LessonRepository _lessonRepository = new LessonRepository();

  HomeScreenPresenter(this._view);

  loadLessonByLevel() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      print(token);
      List<Lesson> listLessons = await _lessonRepository.getLessonsByLevelId(token);
      _view.onLoadLessonSuccess(listLessons);
    } catch (e) {
      _view.onLoadLessonError(e.toString());
    }
  }
}
