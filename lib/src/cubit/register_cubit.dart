
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/states/register_state.dart';
import 'package:vietnamese_learning/src/utils/auth_utils.dart';

class RegisterCubit extends Cubit<RegisterState>{
  final UserRepository _userRepository;

  RegisterCubit(this._userRepository) : super(RegisterInitial());

  Future<void> doRegister(String username, String password, String email, String nation) async{
    try{
      emit(Registering());
      String response = await _userRepository.register(username, password, email, nation);
      if(response == 'Account duplicate!'){
        emit(RegistedError('This account has been exist. Try Again!'));
      }else{
        emit(RegistedSuccess());
      }
    } on Exception{
      emit(RegistedError('Login Failed!'));
    }
  }

}