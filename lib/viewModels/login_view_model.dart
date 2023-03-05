import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';


import '../helpers/enum.dart' as e;
import '../helpers/error_handler.dart';
import '../helpers/set_user_data.dart';
import '../models/user_model.dart';
import '../services/authenticate_service.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPageViewModel extends ChangeNotifier {
  final AuthenticateService _authenticateService = AuthenticateService();
  e.LoginStatus _loginStatus = e.LoginStatus.pending;
  final UserDetailsSet setUser = UserDetailsSet();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();

  e.LoginStatus get loginStatus => _loginStatus;

  late Map<String, dynamic> _userDetails;

  bool showPassword = false;

  Map<String, dynamic> get userDetails => _userDetails;

  Future<void> _setUserDetails(Map<String, dynamic> userDetails) async {
    _userDetails = userDetails;
    if (_userDetails['success'] == false) {
      _loginStatus = e.LoginStatus.failed;
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
      _loginStatus = e.LoginStatus.success;
    }
    notifyListeners();
  }


  loginGoogle() async{
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    await _googleSignIn.signIn();
    login(_googleSignIn.currentUser!.email, _googleSignIn.currentUser!.email);
  }

  loginFaceBook() async {
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]).then((value) async{
      final FacebookAccessToken? accessToken = value.accessToken;
      final profile = await fb.getUserProfile();
      print("this is user value${profile!.firstName}");
    });

    print(res.toString());
  }

  updateShowPassword(){
    if(showPassword){
      showPassword = false;
    }
    else{
      showPassword = true;
    }
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  login(String email, String password) async {
    try {
      _loginStatus = e.LoginStatus.loading;
      _setUserDetails(await _authenticateService.login(email, password));
    } on ShowError catch (error) {
      _loginStatus = e.LoginStatus.error;
      _setError(error);
    }
    notifyListeners();
  }
}
