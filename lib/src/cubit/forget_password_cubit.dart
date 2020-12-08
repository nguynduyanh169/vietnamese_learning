import 'package:bloc/bloc.dart';
import 'package:vietnamese_learning/src/states/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState>{

  ForgetPasswordCubit(): super(InitialChangePassword());

  Future<void> sendEmail() async{
    emit(EnterCode());
  }

  Future<void> enterCode() async{
    emit(ChangePassword());
  }

  Future<void> changePassword() async {
    emit(ChangePasswordSuccess());
  }
}