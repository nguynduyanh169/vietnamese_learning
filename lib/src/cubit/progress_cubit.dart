import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/entrance_quiz_repository.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/models/entrance_quiz.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/states/progress_state.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

class ProgressCubit extends Cubit<ProgressState>{
  ProgressRepository _progressRepository;
  EntranceQuizRepository _entranceQuizRepository;

  ProgressCubit(this._progressRepository): super(InitialCreateProgress());

  Future<void> createProgress(int levelId, LoginResponse loginResponse, String username) async{
    try{
      emit(CreatingProgress());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      AuthUtils.insertDetails(prefs, loginResponse.accessToken, username);
      bool check = await _progressRepository.createProgress(levelId, loginResponse.accessToken);
      print("check");
      if(check == true){
        emit(CreateProgressSuccess());
      }else{
        emit(CreateProgressFail());
      }
    } on Exception{
      emit(CreateProgressFail());
    }
  }

  Future<void> loadEntranceQuiz() async{
    try{
      _entranceQuizRepository = new EntranceQuizRepository();
      emit(LoadingEntranceQuiz());
      List<EntranceQuiz> entranceQuizzes = await _entranceQuizRepository.getEntranceQuiz();
      if(entranceQuizzes.length == 0){
        emit(LoadEntranceQuizFailed());
      }else{
        emit(LoadedEntranceQuiz(entranceQuizzes));
      }
    }on Exception{
      emit(LoadEntranceQuizFailed());
    }
  }

}