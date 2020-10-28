import 'package:vietnamese_learning/src/models/login_respone.dart';

import '../models/login_respone.dart';
import '../models/user.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegistedSuccess extends RegisterState {
  final LoginResponse registerResponse;

  RegistedSuccess(this.registerResponse);
}

class RegistedError extends RegisterState {
  final String message;
  const RegistedError(this.message);
}
