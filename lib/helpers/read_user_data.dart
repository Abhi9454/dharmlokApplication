import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  late SharedPreferences preferences;

  Future<String> getToken() async {
    preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token') ?? '';
    return token;
  }

  Future<String> getUserFullName() async {
    preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString('userFullName') ?? '';
    return userName;
  }

  Future<String> getUserEmail() async {
    preferences = await SharedPreferences.getInstance();
    String userEmail = preferences.getString('userEmail') ?? '';
    return userEmail;
  }
}