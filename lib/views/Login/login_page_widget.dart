import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../main.dart';
import '../../viewModels/login_view_model.dart';
import 'package:provider/provider.dart';

import '../ForgetPasswordPage/forget_password_page_widget.dart';
import '../Registration/registration_page_widget.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPageWidget extends StatelessWidget {
  LoginPageWidget({Key? key}) : super(key: key);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageViewModel>(
      create: (context) => LoginPageViewModel(),
      child: Consumer<LoginPageViewModel>(
        builder: (con, model, _) {
          if (model.loginStatus == LoginStatus.success) {
            return const NavigationTab();
          } else {
            return Scaffold(
              backgroundColor: AppColors.onPrimary,
              body: SafeArea(
                child: model.loginStatus == LoginStatus.loading
                    ? const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        const LogoWidget(),
                        SizedBox(
                          height: context.height * 0.06,
                        ),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: context.height * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              top: 5.0,
                              bottom: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            controller: email,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                                hintText: 'Username/Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              top: 5.0,
                              bottom: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            controller: password,
                            obscureText: model.showPassword,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration:  InputDecoration(
                                hintText: 'Password',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  model.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  model.updateShowPassword();
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        SizedBox(
                          width: context.width * 0.5,
                          height: context.height * 0.06,
                          child: OutlinedButton(
                            onPressed: () {
                              if (email.text.isNotEmpty &&
                                  password.text.isNotEmpty) {
                                model.login(email.text, password.text);
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Empty Fields....',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                  backgroundColor: (AppColors.primary),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(), backgroundColor: AppColors.onPrimary,
                              side: const BorderSide(
                                  width: 1.5, color: AppColors.primary),
                            ),
                            child: const Text(
                              AppStrings.signInButton,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'New here?',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationPageWidget()));
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: context.height * 0.02,),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MultiProvider(
                                            providers: <
                                                ChangeNotifierProvider<
                                                    LoginPageViewModel>>[
                                              ChangeNotifierProvider<
                                                  LoginPageViewModel>(
                                                  create: (_) =>
                                                      LoginPageViewModel())
                                            ],
                                            child:
                                            ForgetPasswordPageWidget())));
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: context.height * 0.05,),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          onPressed: () async {
                            await model.loginGoogle();
                          },
                        ),
                        SizedBox(height: context.height * 0.02,),
                        SignInButton(
                          Buttons.Facebook,
                          text: "Sign in with Facebook",
                          onPressed: () {
                            model.loginFaceBook();
                          },
                        ),
                        SizedBox(height: context.height * 0.1,),
                        model.loginStatus == LoginStatus.failed
                            ? const Text(
                          'Email/ Password Incorrect',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                            : const SizedBox(),
                        model.loginStatus == LoginStatus.error
                            ? Text(
                          model.error.message,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}