import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsSet {
  late SharedPreferences preferences;
  bool success = false;

  Future<bool> setUserDetails(String userFullName, String userEmail, String userType,String phone, String token) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('userFullName', userFullName);
    preferences.setString('userEmail', userEmail);
    preferences.setString('userType', userType );
    preferences.setString('phoneNumber', phone );
    preferences.setString('token', token );
    success = true;
    return success;
  }

  Future<bool> setUserFullName(String userFullName) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('userFullName', userFullName);
    success = true;
    return success;
  }
}