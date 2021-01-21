import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/data/quiz_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/quiz_submit.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/submit_quiz_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class SubmitQuizCubit extends Cubit<SubmitQuizState> {
  final QuizRepository _quizRepository;

  SubmitQuizCubit(this._quizRepository) : super(SubmitQuizInit());

  Future<void> submitQuiz({List<ListAswer> listAnswer, int quizId, double quizMark, String lessonId, Progress progress}) async {
    emit(SubmittingQuiz());
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      ProgressRepository progressRepository = new ProgressRepository();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      HiveUtils _hiveUtils = new HiveUtils();
      DateTime dateTime = DateTime.now();
      SaveProgressLocal progressLocal = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonId);
      progressLocal.quizProgress = quizMark;
      progressLocal.updateTime = dateTime;
      if(connectivityResult == ConnectivityResult.none) {
        _hiveUtils.updateLocalProgress(progressLocal: progressLocal, boxName: HiveBoxName.PROGRESS_BOX);

      }else{
        progressLocal.isSync = true;
        _hiveUtils.updateLocalProgress(progressLocal: progressLocal, boxName: HiveBoxName.PROGRESS_BOX);
        progress.converPercent = progressLocal.converProgress * 10;
        progress.vocabPercent = progressLocal.vocabProgress * 10;
        progress.quizPercent = quizMark * 10;
        progress.updateDate = dateTime.toIso8601String();
        QuizSubmit quizSubmit = new QuizSubmit(
            lessonId: lessonId,
            progress: progress,
            listAswers: listAnswer,
            quizMark: quizMark,
            startDate: dateTime);
        bool check = await _quizRepository.submitQuiz(token, quizSubmit);
        Progress responseProgress = await progressRepository.syncProgress(token, progress);
        if (check == true) {
          emit(SubmitQuizSuccess());
        } else if (check == false) {
          emit(SubmitQuizFailed('Submit Quiz Failed!'));
        }
      }

    } on Exception {
      emit(SubmitQuizFailed('Submit Quiz Failed!'));
    }
  }
}
