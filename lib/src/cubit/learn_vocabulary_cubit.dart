import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/states/learn_vocabulary_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class LearnVocabularyCubit extends Cubit<LearnVocabularyState>{
  int vocabulariesLength;
  LearnVocabularyCubit(this.vocabulariesLength) : super(LearnVocabularyInitial());

  Future<void> learnFlashCard(int vocabulariesIndex) async{
    print(vocabulariesIndex);
    if(vocabulariesIndex > vocabulariesLength - 1){
      print(vocabulariesIndex);
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularyFlashCard(vocabulariesIndex));
    }
  }

  Future<void> learnSpeaking(int vocabulariesIndex) async{
    if(vocabulariesIndex > vocabulariesLength - 1){
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularySpeaking(vocabulariesIndex));
    }
  }

  Future<void> learnMatching(int vocabulariesIndex) async{
    if(vocabulariesIndex > vocabulariesLength - 1){
      emit(LearnVocabularyDone(vocabulariesLength));
    }
    else {
      emit(LearnVocabularyPuzzle(vocabulariesIndex));
    }
  }

  Future<void> submitProgress(double finalMark, String lessonID, Progress progress) async{
    emit(SubmittingProgress());
    ProgressRepository progressRepository = new ProgressRepository();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken');
    HiveUtils _hiveUtils = new HiveUtils();
    SaveProgressLocal updateProgress = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonID);
    updateProgress.vocabProgress = finalMark;
    DateTime now = DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    updateProgress.updateTime = currentDate.toLocal();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      _hiveUtils.updateLocalProgress(progressLocal: updateProgress, boxName: HiveBoxName.PROGRESS_BOX);
    }else{
      updateProgress.isSync = true;
      _hiveUtils.updateLocalProgress(progressLocal: updateProgress, boxName: HiveBoxName.PROGRESS_BOX);
      progress.vocabPercent = updateProgress.vocabProgress * 10;
      progress.updateDate = currentDate.toIso8601String();
      Progress responseProgress = await progressRepository.syncProgress(token, progress);
    }
    emit(SubmittedProgress());
  }
}