
import 'package:vietnamese_learning/src/models/login_respone.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/providers/user_provider.dart';

class UserRepository {

  UserProvider _userProvider = new UserProvider();

  Future<LoginResponse> login(String username, String password) {
    return _userProvider.login(username, password);
  }

  Future<LoginResponse> register(String username, String password, String email, String nation) {
    return _userProvider.register(username, password, email, nation);
  }

  Future<UserProfile> getUserProfile(String token, String username){
    return _userProvider.getUserProfile(token, username);
  }

  Future<String> getCode(String email){
    return _userProvider.getCode(email);
  }

  Future<bool> changePassword(String email, String newPassword){
    return _userProvider.changePassword(email, newPassword);
  }
}