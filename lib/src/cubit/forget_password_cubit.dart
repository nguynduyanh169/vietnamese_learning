import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/states/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState>{
  UserRepository _userRepository;
  ForgetPasswordCubit(this._userRepository): super(InitialChangePassword());

  Future<void> sendEmail(String email) async{
    try{
      emit(SendEmail());
      String result = await _userRepository.getCode(email);
      if(result == 'Invalid Email'){
        emit(SendEmailFailed());
      }else{
        emit(EnterCode(result));
      }
    }on Exception{
      emit(SendEmailFailed());
    }

  }

  Future<void> enterCode(String code, String inputCode) async{
    if(code == inputCode) {
      emit(ChangePassword());
    }else if(code != inputCode){
      emit(EnterCodeInvalid());
    }
  }

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