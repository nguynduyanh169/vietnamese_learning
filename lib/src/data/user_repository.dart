
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/providers/user_provider.dart';

class UserRepository {

  UserProvider _userProvider = new UserProvider();

  Future<LoginResponse> login(String username, String password) {
    return _userProvider.login(username, password);
  }

  Future<LoginResponse> register(String username, String password, String email, String nation) {
    return _userProvider.register(username, password, email, nation);
  }
}