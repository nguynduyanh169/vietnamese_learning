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

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
