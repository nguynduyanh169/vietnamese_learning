abstract class ForgetPasswordState{
  const ForgetPasswordState();
}

class InitialChangePassword extends ForgetPasswordState{
  const InitialChangePassword();
}

class SendEmail extends ForgetPasswordState{
  const SendEmail();
}

class EnterCode extends ForgetPasswordState{
  const EnterCode();
}

class ChangePassword extends ForgetPasswordState{
  const ChangePassword();
}

class ChangePasswordSuccess extends ForgetPasswordState{
  const ChangePasswordSuccess();
}
