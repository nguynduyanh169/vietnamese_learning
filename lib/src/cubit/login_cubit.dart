
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/states/login_state.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

class LoginCubit extends Cubit<LoginState>{
  final UserRepository _userRepository;

  LoginCubit(this._userRepository) : super(LoginInitial());

  Future<void> doLogin(String username, String password) async{
    try{
      LoginResponse response = await _userRepository.login(username, password);
      if(response.tokenType == 'Fail'){
        emit(LoginError('Login Error!'));
      }else{
        emit(LoginProcess(response));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        AuthUtils.insertDetails(prefs, response.accessToken, username);
      }
    } on Exception{
      emit(LoginError('Login Failed!'));
    }
  }

}