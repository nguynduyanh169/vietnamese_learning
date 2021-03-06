import 'package:vietnamese_learning/src/models/nation.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';

abstract class EditProfileState{
  const EditProfileState();
}

class IntitialEditProfile extends EditProfileState{
  const IntitialEditProfile();
}

class LoadingEditProfile extends EditProfileState{
  const LoadingEditProfile();
}

class LoadedEditProfile extends EditProfileState{
  final List<Nation> nations;
  final UserProfile userProfile;
  const LoadedEditProfile(this.userProfile, this.nations);
}

class LoadEditProfileFailed extends EditProfileState{
  const LoadEditProfileFailed();
}

class EditingProfile extends EditProfileState{
  const EditingProfile();
}

class EditProfileFailed extends EditProfileState{
  final String message;
  const EditProfileFailed(this.message);
}

class EditProfileSuccess extends EditProfileState{
  const EditProfileSuccess();
}
