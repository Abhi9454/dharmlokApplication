import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/helpers/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppColors.dart';
import '../../viewModels/form_page_view_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class FormPageWidget extends StatefulWidget {
  const FormPageWidget({Key? key, required this.poojaName, required this.providerId, required this.serviceId}) : super(key: key);

  final String poojaName;
  final String providerId;
  final String serviceId;

  @override
  State<FormPageWidget> createState() => _FormPageWidgetState();
}

class _FormPageWidgetState extends State<FormPageWidget> {
  TextEditingController fullName = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController city = TextEditingController();

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        dateController.text = date;
      });
    }
  }

  final GlobalKey<ScaffoldState> _formPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<FormPageViewModel>(context,listen: false).getUserLocation();
    Provider.of<FormPageViewModel>(context,listen: false).getAllStates();
    return Consumer<FormPageViewModel>(
      builder: (con, formModel, _){
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      HomePageAppBarWidget(
                        scaffoldKey: _formPageKey,
                        location: formModel.userLocation,
                        languageButtonPressed: () {},
                        logoutPressed: () {},
                      ),
                      SizedBox(
                        height: context.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              )),
                          const Text(
                            'Enter Details',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Form(
                        child: Column(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height:
                              context.height *
                                  0.02,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 15.0,
                                  right: 15,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller:
                                fullName,
                                keyboardType:
                                TextInputType
                                    .phone,
                                style: const TextStyle(
                                    color: Colors
                                        .black,
                                    fontSize: 18),
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    'Full Name',
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height:
                              context.height *
                                  0.02,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 15.0,
                                  right: 15,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller:
                                mobile,
                                keyboardType:
                                TextInputType
                                    .phone,
                                style: const TextStyle(
                                    color: Colors
                                        .black,
                                    fontSize: 18),
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    'Mobile Number',
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height:
                              context.height *
                                  0.02,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 15.0,
                                  right: 15,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller:
                                dateController,
                                maxLines: 1,
                                readOnly: true,
                                style: const TextStyle(
                                    color: Colors
                                        .black,
                                    fontSize: 18),
                                decoration:
                                InputDecoration(
                                  prefixIcon: IconButton(onPressed: (){
                                    _selectDate(context);
                                  }, icon: const Icon(Icons.date_range)),
                                  hintText:
                                  'Pooja Dates',
                                  enabledBorder:
                                  const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black,
                                        width: 0.0),
                                    borderRadius: BorderRadius
                                        .all(Radius
                                        .circular(
                                        10)),
                                  ),
                                  focusedBorder:
                                  const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black,
                                        width: 0.0),
                                    borderRadius: BorderRadius
                                        .all(Radius
                                        .circular(
                                        10)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                              context.height *
                                  0.02,
                            ),Padding(
                              padding: const EdgeInsets.only(left: 15.0,
                                  right: 15,
                                  top: 5.0,
                                  bottom: 5.0),
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
                                    value: formModel.selectedState,
                                    //elevation: 5,
                                    style: const TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.black,
                                    items: formModel.states
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
                                        formModel.setSelectedState(newValue);
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
                              padding:
                              const EdgeInsets
                                  .only(
                                  left: 15.0,
                                  right: 15,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                controller:
                                city,
                                keyboardType:
                                TextInputType
                                    .phone,
                                style: const TextStyle(
                                    color: Colors
                                        .black,
                                    fontSize: 18),
                                decoration:
                                const InputDecoration(
                                    hintText:
                                    'City',
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .black,
                                          width:
                                          0.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                    )),
                              ),
                            ),

                            SizedBox(
                              height:
                              context.height *
                                  0.02,
                            ),

                            Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child:  ElevatedButton(
                                onPressed: () {
                                  if(fullName.text.isNotEmpty && mobile.text.isNotEmpty &&
                                  city.text.isNotEmpty && dateController.text.isNotEmpty && formModel.selectedState !='Select state'){
                                    formModel.addEnquiry(fullName.text, mobile.text, dateController.text, widget.poojaName,
                                        widget.providerId, widget.serviceId,city.text);
                                  }
                                  else{
                                    const snackBar = SnackBar(
                                      content: Text(
                                        'Empty Fields.Fill all details.',
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
                                style: ElevatedButton
                                    .styleFrom(
                                    backgroundColor:
                                    Colors
                                        .green),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors
                                          .white),
                                ),
                              ),
                            ),
                            formModel.status == Status.success
                                ? const Text(
                              'Details Submitted Successfully',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
