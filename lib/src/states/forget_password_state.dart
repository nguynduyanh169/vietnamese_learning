abstract class ForgetPasswordState{
  const ForgetPasswordState();
}

class InitialChangePassword extends ForgetPasswordState{
  const InitialChangePassword();
}

class SendEmail extends ForgetPasswordState{
  const SendEmail();
}

class SendEmailFailed extends ForgetPasswordState{
  const SendEmailFailed();
}

class EnterCode extends ForgetPasswordState{
  final String code;
  const EnterCode(this.code);
}

class EnterCodeInvalid extends ForgetPasswordState{
 const EnterCodeInvalid();
}

class ChangePassword extends ForgetPasswordState{
  const ChangePassword();
}

class ChangePasswordSuccess extends ForgetPasswordState{
  const ChangePasswordSuccess();
}

class ChangingPassword extends ForgetPasswordState{
  const ChangingPassword();
}

class ChangePasswordFailed extends ForgetPasswordState{
  const ChangePasswordFailed();
}
