
import 'package:vietnamese_learning/src/models/user_profile.dart';

abstract class IntroState {
  const IntroState();
}

class AutoLoginLoading extends IntroState{
  const AutoLoginLoading();
}

class AutoLoginSuccess extends IntroState{
  const AutoLoginSuccess();
}

class AutoLoginFailed extends IntroState{
  const AutoLoginFailed();
}

