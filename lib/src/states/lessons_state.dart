
import 'dart:convert';

import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';

abstract class LessonsState{
  const LessonsState();
}

class LessonsLoading extends LessonsState{
  const LessonsLoading();
}

class LessonsLoaded extends LessonsState{
  final List<Lesson> lessons;
  final UserProfile userProfile;
  const LessonsLoaded(this.lessons, this.userProfile);
}

class LessonLoadError extends LessonsState{
  final String error;
  const LessonLoadError(this.error);
}

class ReloadLessonsSuccess extends LessonsState{
  final List<Lesson> lessons;
  const ReloadLessonsSuccess(this.lessons);
}

class ReloadingLessons extends LessonsState{
  const ReloadingLessons();
}
