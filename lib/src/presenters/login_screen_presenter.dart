import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LoginResponse response);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  UserRepository _userRepository = new UserRepository();
  LoginScreenPresenter(this._view);
  doLogin(String username, String password) async {
    try {
      LoginResponse response = await _userRepository.login(username, password);
      _view.onLoginSuccess(response);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      AuthUtils.insertDetails(prefs, response.accessToken, username);
    } catch (e) {
      _view.onLoginError(e.toString());
    }
  }
}
