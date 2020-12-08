import 'package:vietnamese_learning/src/models/login_respone.dart';

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
