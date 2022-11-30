import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/manage_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppColors.dart';
import '../../helpers/enum.dart';
import '../../viewModels/main_view_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class ManageProfilePageWidget extends StatelessWidget {
  ManageProfilePageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _manageProfileKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    Provider.of<ManageProfileViewModel>(context,listen: false).getUserLocation();
    Provider.of<ManageProfileViewModel>(context,listen: false).getVendorDetails();
    Provider.of<ManageProfileViewModel>(context,listen: false).getAllStates();
    return Consumer<ManageProfileViewModel>(
      builder: (con, manageModel, _) {
        return Scaffold(
          key: _manageProfileKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _manageProfileKey,
                      location: manageModel.userLocation,
                      languageButtonPressed: () {},
                      logoutPressed: () {},
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    const Text(
                      'Manage Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Expanded(
                      child: manageModel.status == Status.loading ?
                          const Center(child: CircularProgressIndicator(),) :
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // CircleAvatar(
                            //   radius: 100,
                            //   child: Image.network(
                            //     'https://dharmlok.s3.amazonaws.com/${manageModel.profileImageUrl}',
                            //   ),
                            // ),
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(80), // Image radius
                                child: Image.network('https://dharmlok.s3.amazonaws.com/${manageModel.profileImageUrl}', fit: BoxFit.cover),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                            //   child: TextFormField(
                            //     autofocus: false,
                            //     controller: manageModel.email,
                            //     style:
                            //     const TextStyle(color: Colors.black, fontSize: 18),
                            //     decoration: const InputDecoration(
                            //         hintText: 'Email',
                            //         enabledBorder: OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Colors.grey, width: 0.0),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(10)),
                            //         ),
                            //         focusedBorder: OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Colors.grey, width: 0.0),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(10)),
                            //         )),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: context.height * 0.02,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller: manageModel.fullName,
                                style:
                                const TextStyle(color: Colors.black, fontSize: 18),
                                decoration: const InputDecoration(
                                    hintText: 'Full Name',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller: manageModel.phone,
                                keyboardType: TextInputType.phone,
                                style:
                                const TextStyle(color: Colors.black, fontSize: 18),
                                decoration: const InputDecoration(
                                    hintText: 'Phone Number',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.black, width: 0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    focusColor: Colors.white,
                                    value: manageModel.selectedState,
                                    //elevation: 5,
                                    style: const TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.black,
                                    items: manageModel.states
                                        .map<DropdownMenuItem<String>>(
                                            (String typeValue) {
                                          return DropdownMenuItem<String>(
                                            value: typeValue,
                                            child: Text(
                                              typeValue,
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 18),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue! != 'Select state') {
                                        manageModel.setSelectedState(newValue);
                                      }
                                    },
                                    hint: const Text(
                                      'Select State',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.black, width: 0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    focusColor: Colors.white,
                                    value: manageModel.selectedCity,
                                    //elevation: 5,
                                    style: const TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.black,
                                    items: manageModel.cities
                                        .map<DropdownMenuItem<String>>(
                                            (String typeValue) {
                                          return DropdownMenuItem<String>(
                                            value: typeValue,
                                            child: Text(
                                              typeValue,
                                              style: const TextStyle(
                                                  color: Colors.black, fontSize: 18),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue! != 'Select city') {
                                        manageModel.setSelectedCity(newValue);
                                      }
                                    },
                                    hint: const Text(
                                      'Select City',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller: manageModel.address,
                                keyboardType: TextInputType.text,
                                style:
                                const TextStyle(color: Colors.black, fontSize: 18),
                                decoration: const InputDecoration(
                                    hintText: 'Enter Address',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.black, width: 0.0),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (manageModel.fullName.text.isNotEmpty &&
                                    manageModel.phone.text.isNotEmpty &&
                                    manageModel.selectedState != 'Select state' &&
                                    manageModel.selectedCity != 'Select city') {
                                  manageModel.updateUserDetails(manageModel.fullName.text,
                                      manageModel.email.text, manageModel.phone.text, manageModel.address.text,context);
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Empty fields. Please try again..',
                                      style:
                                      TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                    backgroundColor: (AppColors.primary),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
