import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/set_user_data.dart';
import '../main.dart';
import '../models/user_model.dart';
import '../services/authenticate_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthenticateService _authenticateService = AuthenticateService();
  LoginStatus _loginStatus = LoginStatus.pending;
  final UserDetailsSet setUser = UserDetailsSet();

  LoginStatus get loginStatus => _loginStatus;

  late Map<String, dynamic> _userDetails;

  Map<String, dynamic> get userDetails => _userDetails;

  Future<void> _setUserDetails(Map<String, dynamic> userDetails, BuildContext context) async {
    _userDetails = userDetails;
    if (_userDetails['success'] == false) {
      _loginStatus = LoginStatus.failed;
    } else {
      List<UserModel> list = ((_userDetails['message'] as List)
          .map((i) => UserModel.fromJson(i))
          .toList());
      setUser.setUserDetails(
        list[0].userFullName,
        list[0].userEmail,
        list[0].userType,
        list[0].phoneNumber,
        list[0].token,
      );
      _loginStatus = LoginStatus.success;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NavigationTab()),
              (Route<dynamic> route) => false);
    }
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  register(String email, String password, String name, String phone, BuildContext context) async {
    try {
      print('This is called');
      _loginStatus = LoginStatus.loading;
      _setUserDetails(await _authenticateService.register(email, password,name,phone),context);
    } on ShowError catch (error) {
      _loginStatus = LoginStatus.error;
      _setError(error);
    }
    notifyListeners();
  }
}
