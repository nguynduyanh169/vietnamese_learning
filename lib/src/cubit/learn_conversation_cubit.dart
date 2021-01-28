import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/constants.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/models/lesson.dart';
import 'package:vietnamese_learning/src/models/save_progress_local.dart';
import 'package:vietnamese_learning/src/states/learn_converasation_state.dart';
import 'package:vietnamese_learning/src/utils/hive_utils.dart';

class LearnConversationCubit extends Cubit<LearnConversationState> {
  int conversationsLength;
  LearnConversationCubit(this.conversationsLength)
      : super(LearnConversationInitial());

  Future<void> learnFlashCard(int conversationsIndex) async {
    print(conversationsIndex);
    if (conversationsIndex > conversationsLength - 1) {
      print(conversationsIndex);
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationFlashCard(conversationsIndex));
    }
  }

  Future<void> learnSpeaking(int conversationsIndex) async {
    if (conversationsIndex > conversationsLength - 1) {
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationSpeaking(conversationsIndex));
    }
  }

  Future<void> learnMatching(int conversationsIndex) async {
    if (conversationsIndex > conversationsLength - 1) {
      emit(LearnConversationDone(conversationsLength));
    } else {
      emit(LearnConversationPuzzle(conversationsIndex));
    }
  }

  Future<void> submitProgress(double finalMark, String lessonID, Progress progress) async{
    emit(SubmittingProgress());
    ProgressRepository progressRepository = new ProgressRepository();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('accessToken');
    HiveUtils _hiveUtils = new HiveUtils();
    SaveProgressLocal updateProgress = _hiveUtils.getLocalProgress(boxName: HiveBoxName.PROGRESS_BOX, lessonId: lessonID);
    updateProgress.converProgress = finalMark;
    DateTime now = DateTime.now();
    DateTime currentDate = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    updateProgress.updateTime = currentDate.toLocal();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none){
      _hiveUtils.updateLocalProgress(progressLocal: updateProgress, boxName: HiveBoxName.PROGRESS_BOX);
    }else{
      updateProgress.isSync = true;
      _hiveUtils.updateLocalProgress(progressLocal: updateProgress, boxName: HiveBoxName.PROGRESS_BOX);
      progress.converPercent = updateProgress.converProgress * 10;
      progress.updateDate = currentDate.toIso8601String();
      Progress responseProgress = await progressRepository.syncProgress(token, progress);
    }
    emit(SubmittedProgress());
  }
}
