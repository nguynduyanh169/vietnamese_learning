
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/providers/lesson_provider.dart';

class LessonRepository {
  LessonProvider _lessonProvider = new LessonProvider();

  Future<List<Lesson>> getLessonsByLevelId(String token) {
    return _lessonProvider.getLessonByLevel(token);
  }

  Future<List<Lesson>> getLessonsLocal() {
    return _lessonProvider.getLessonLocal();
  }

  Future<List<Lesson>> getLessonsLocalJson() {
    return _lessonProvider.getLessonLocalJson();
  }


}
