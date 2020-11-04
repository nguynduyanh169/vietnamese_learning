import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/states/intro_state.dart';

class IntroCubit extends Cubit<IntroState>{
  IntroCubit(): super(AutoLoginLoading());

  Future<void> autoLoading() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username');
    final String token= prefs.getString('accessToken');
    if (username != null || token != null) {
      emit(AutoLoginSuccess());
    }else{
      emit(AutoLoginFailed());
    }
  }
}