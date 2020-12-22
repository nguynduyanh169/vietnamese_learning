import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/states/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>{
  UserRepository _userRepository;
  ChangePasswordCubit(this._userRepository): super(InitialChangePassword());

  Future<void> changePassword(String email, String newPassword, String confirmNewPassword) async {
    try{
      emit(ChangingPassword());
      if(newPassword != confirmNewPassword){
        emit(ChangePasswordFailed());
      }else {
        bool check = await _userRepository.changePassword(email, newPassword);
        if (check == true) {
          emit(ChangePasswordSuccess());
        } else {
          emit(ChangePasswordFailed());
        }
      }
    }on Exception{
      emit(ChangePasswordFailed());
    }
  }
}