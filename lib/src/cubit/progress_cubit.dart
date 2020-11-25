import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/progress_repository.dart';
import 'package:vietnamese_learning/src/states/create_post_state.dart';
import 'package:vietnamese_learning/src/states/progress_state.dart';

class ProgressCubit extends Cubit<ProgressState>{
  ProgressRepository _progressRepository;

  ProgressCubit(this._progressRepository): super(InitialCreateProgress());

  Future<void> createProgress(int levelId) async{
    try{
      emit(CreatingProgress());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check = await _progressRepository.createProgress(levelId, token);
      if(check == true){
        emit(CreateProgressSuccess());
      }else{
        emit(CreateProgressFail());
      }
    } on Exception{
      emit(CreateProgressFail());
    }
  }

}