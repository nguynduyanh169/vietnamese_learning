import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginProcess extends LoginState {
  final LoginResponse loginResponse;
  LoginProcess(this.loginResponse);
}

class NewLoginProcess extends LoginState{
  final String username;
  final LoginResponse loginResponse;
  NewLoginProcess(this.loginResponse, this.username);
}

class DoingLogin extends LoginState{
  const DoingLogin();
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}

class LoginGmailSuccess extends LoginState{
  const LoginGmailSuccess();
}

class LoginGmailFail extends LoginState{
  final String message;
  const LoginGmailFail(this.message);
}

class NewLoginGmail extends LoginState{
  final String username;
  final LoginResponse loginResponse;
  NewLoginGmail(this.username, this.loginResponse);
}
