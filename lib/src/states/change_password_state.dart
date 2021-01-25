abstract class ChangePasswordState{
  const ChangePasswordState();
}

class InitialChangePassword extends ChangePasswordState{
  const InitialChangePassword();
}

class ChangingPassword extends ChangePasswordState{
  const ChangingPassword();
}

class ChangePasswordSuccess extends ChangePasswordState{
  const ChangePasswordSuccess();
}

class ChangePasswordFailed extends ChangePasswordState{
  const ChangePasswordFailed();
}

class NoInternet extends ChangePasswordState{
  const NoInternet();
}
