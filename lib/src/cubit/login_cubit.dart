import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/login_state.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository;

  LoginCubit(this._userRepository) : super(LoginInitial());

  Future<void> doLogin(String username, String password) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      emit(DoingLogin());
      if (connectivityResult == ConnectivityResult.none) {
        emit(LoginError('No Internet Connection!'));
      } else {
        LoginResponse response =
            await _userRepository.login(username, password);
        if (response.tokenType == 'Fail') {
          emit(LoginError('Invalid username or password!'));
        } else {
          Map<String, dynamic> decodeToken =
              JwtDecoder.decode(response.accessToken);
          if (decodeToken['level-id'] == 0) {
            emit(NewLoginProcess(response, username));
          } else {
            emit(LoginProcess(response));
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            AuthUtils.insertDetails(prefs, response.accessToken, username);
          }
        }
      }
    } on Exception {
      emit(LoginError('Login Failed!'));
    }
  }

  Future<void> doLoginGmail(String email, String fullname, String uid,
      String avatarLink, String username) async {
    try {
      emit(DoingLoginGmail());
      LoginResponse jwtToken = await _userRepository.login_gmail(
          avatarLink, email, fullname, uid, username);
      if (jwtToken.tokenType == 'Fail') {
        emit(LoginGmailFail(('Login Error!')));
      } else {
        Map<String, dynamic> decodeToken =
            JwtDecoder.decode(jwtToken.accessToken);
        if (decodeToken['level-id'] == 0) {
          emit(NewLoginGmail(username, jwtToken));
        } else {
          emit(LoginProcess(jwtToken));
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          AuthUtils.insertDetails(preferences, jwtToken.accessToken, username);
        }
      }
    } on Exception {
      emit(LoginGmailFail('Login Failed'));
    }
  }
}
