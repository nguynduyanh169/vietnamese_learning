import 'package:shared_preferences/shared_preferences.dart';
class AuthUtils {
  static final String token = 'accessToken';
  static final String usernameKey = 'username';

  static String getToken(SharedPreferences prefs) {
    return prefs.getString(token);
  }

  static String getUsername(SharedPreferences prefs){
    return prefs.getString(usernameKey);
  }

  static insertDetails(SharedPreferences prefs,String accessToken, String username) {
    prefs.setString(token, accessToken);
    prefs.setString(usernameKey, username);
  }

}