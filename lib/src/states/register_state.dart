import 'package:vietnamese_learning/src/models/login_respone.dart';

import '../models/login_respone.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class Registering extends RegisterState{
  const Registering();
}

class RegistedSuccess extends RegisterState {
  //final LoginResponse registerResponse;

  const RegistedSuccess();
}

class RegistedError extends RegisterState {
  final String message;
  const RegistedError(this.message);
}
