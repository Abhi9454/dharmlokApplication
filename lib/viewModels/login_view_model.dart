import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';


import '../helpers/enum.dart' as e;
import '../helpers/error_handler.dart';
import '../helpers/set_user_data.dart';
import '../models/user_model.dart';
import '../services/authenticate_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;


class LoginPageViewModel extends ChangeNotifier {
  final AuthenticateService _authenticateService = AuthenticateService();
  e.LoginStatus _loginStatus = e.LoginStatus.pending;
  e.ForgetPassword _forgetPasswordStatus = e.ForgetPassword.pending;
  final UserDetailsSet setUser = UserDetailsSet();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FacebookLogin();

  e.LoginStatus get loginStatus => _loginStatus;
  e.ForgetPassword get forgetPasswordStatus => _forgetPasswordStatus;

  late Map<String, dynamic> _userDetails;

  late Map<String, dynamic> _forgetPassword;

  bool showPassword = false;

  Map<String, dynamic> get userDetails => _userDetails;

  Map<String, dynamic> get forgetPassword => _forgetPassword;

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

  Future<void> _setForgetPassword(Map<String, dynamic> forgetPassword) async {
    _forgetPassword = forgetPassword;
    if (_forgetPassword['success'] == false) {
      _forgetPasswordStatus = e.ForgetPassword.failed;
    } else {
      _forgetPasswordStatus = e.ForgetPassword.success;
    }
    notifyListeners();
  }


  loginGoogle() async{
    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //     //   scopes: [
    //     //     'email',
    //     //     'https://www.googleapis.com/auth/contacts.readonly',
    //     //   ],
    //     // );
    //     // await _googleSignIn.signIn();
    //     // login(_googleSignIn.currentUser!.email, _googleSignIn.currentUser!.email);
    final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile']
    );
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      login(googleSignInAccount.email, googleSignInAccount.email,googleSignInAccount.displayName ?? 'Google User', (Random().nextInt(3331212323) + 2311232212).toString(),"user", "","", 1);
    }
  }

  loginFaceBook() async {
    var facebookLoginResult =
    await fb.logIn(permissions: [FacebookPermission.email, FacebookPermission.publicProfile]);
    if(facebookLoginResult.status == FacebookLoginStatus.success){
      var graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken?.token}'));

      var profile = json.decode(graphResponse.body);
      login(profile["email"], profile["email"], profile["name"], (Random().nextInt(3331212323) + 2311232212).toString(),"user", "","", 1);
    }
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

  login(String email, String password,String name,String phone,String userType,String typeVendor,String category,int social) async {
    try {
      _loginStatus = e.LoginStatus.loading;
      _setUserDetails(await _authenticateService.login(email, password, name ,phone, social));
    } on ShowError catch (error) {
      _loginStatus = e.LoginStatus.error;
      _setError(error);
    }
    notifyListeners();
  }

  forgetPass(String email) async {
    try {
      _forgetPasswordStatus = e.ForgetPassword.loading;
      _setForgetPassword(await _authenticateService.forgetPassword(email));
    } on ShowError catch (error) {
      _forgetPasswordStatus = e.ForgetPassword.error;
      _setError(error);
    }
    notifyListeners();
  }
}
