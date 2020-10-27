
import 'dart:convert';

import 'package:vietnamese_learning/src/models/lesson.dart';

abstract class LessonsState{
  const LessonsState();
}

class LessonsLoading extends LessonsState{
  const LessonsLoading();
}

class LessonsLoaded extends LessonsState{
  final List<Lesson> lessons;
  const LessonsLoaded(this.lessons);
}

class LessonLoadError extends LessonsState{
  final String error;
  const LessonLoadError(this.error);
}