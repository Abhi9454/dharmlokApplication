import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/helpers/enum.dart';
import 'package:dharmlok/viewModels/register_view_model.dart';
import 'package:dharmlok/views/Login/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppStrings.dart';
import '../../widgets/logo_widget.dart';

class RegistrationPageWidget extends StatelessWidget {
   RegistrationPageWidget({Key? key}) : super(key: key);


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

   Future<void> _launchInBrowser() async {
     if (!await launchUrl(
       Uri.parse('https://dharmlok.com/#/login/register'),
       mode: LaunchMode.externalApplication,
     )) {
       throw 'Could not launch';
     }
   }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(),
      child: Consumer<RegisterViewModel>(
        builder: (con, registerModel, _){
          return Scaffold(
            body: registerModel.loginStatus == LoginStatus.loading ?
                const Center(child: CircularProgressIndicator(),)
                :
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                  const LogoWidget(),
                  SizedBox(
                    height: context.height * 0.06,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right:  15.0, bottom: 10.0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right:  15.0, bottom: 10.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: email,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right:  15.0, bottom: 10.0),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right:  15.0, bottom: 10.0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: password,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right:  15.0, bottom: 10.0),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          controller: confirmPassword,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  SizedBox(
                    width: context.width * 0.5,
                    height: context.height * 0.06,
                    child: OutlinedButton(
                      onPressed: () {
                        if (email.text.isNotEmpty &&
                            password.text.isNotEmpty && name.text.isNotEmpty
                            && confirmPassword.text.isNotEmpty && phoneNumber.text.isNotEmpty) {
                          if(confirmPassword.text != password.text){
                            const snackBar = SnackBar(
                              content: Text(
                                'Password and Confirm Password do not match.',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              backgroundColor: (AppColors.primary),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          else{
                            registerModel.register(email.text, password.text, name.text, phoneNumber.text,context);
                          }
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
                        'Sign Up',
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
                        'Already have an account?',
                        style: TextStyle(
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPageWidget()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Are you a vendor?',
                        style: TextStyle(
                            fontWeight: FontWeight.normal),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: InkWell(
                          onTap: () {
                            _launchInBrowser();
                          },
                          child: const Text(
                            'Sign up here',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.height * 0.1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
