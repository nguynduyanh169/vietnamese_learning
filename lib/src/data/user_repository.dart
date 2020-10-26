
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/providers/user_provider.dart';

class UserRepository {

  UserProvider _userProvider = new UserProvider();

  Future<LoginResponse> login(String username, String password) {
    return _userProvider.login(username, password);
  }
}