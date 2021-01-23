abstract class ProfileState{
  const ProfileState();
}

class Initial extends ProfileState{
  const Initial();
}

class LoggingOut extends ProfileState{
  const LoggingOut();
}

class LogoutSuccess extends ProfileState{
  const LogoutSuccess();
}
class LogoutFailed extends ProfileState{
  final String message;
  const LogoutFailed(this.message);
}