import '../../extensions/device_size.dart';
import '../../helpers/enum.dart';
import '../../viewModels/dharmshala_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class DharmshalaFormPageWidget extends StatefulWidget {
  const DharmshalaFormPageWidget({Key? key, required this.type}) : super(key: key);


  final String type;

  @override
  State<DharmshalaFormPageWidget> createState() => _DharmshalaFormPageWidget();
}

class _DharmshalaFormPageWidget extends State<DharmshalaFormPageWidget> {
  TextEditingController fullName = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController tourDetails = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController person = TextEditingController();

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
    return Consumer<DharmshalaFormPageViewModel>(
      builder: (con, dharmshalaForm, _) {
        return Scaffold(
            body: SafeArea(
                child: Stack(children: [
          const BackgroundImageWidget(),
          const BackgroundOverlayWidget(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HomePageAppBarWidget(
                  scaffoldKey: _formPageKey,
                  location: dharmshalaForm.userLocation,
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
                dharmshalaForm.status == Status.success
                    ? const Center(
                      child: Text(
                  'Details Submitted Successfully',
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                ),
                    )
                    : const SizedBox(),
                Form(
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: fullName,
                        keyboardType: TextInputType.phone,
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
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                            hintText: 'Email',
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
                            controller: mobile,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
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
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5.0, bottom: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        controller: dateController,
                        maxLines: 1,
                        readOnly: true,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          prefixIcon: IconButton(onPressed: (){
                            _selectDate(context);
                          },
                              icon:const Icon(Icons.date_range)),
                          hintText: 'Travel Dates',
                          enabledBorder: const OutlineInputBorder(
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
                        controller: tourDetails,
                        maxLines: 5,
                        keyboardType: TextInputType.emailAddress,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                            hintText: 'Tour Description',
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
                        controller: person,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                            hintText: 'Number of Person',
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
                        controller: duration,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                            hintText: 'Duration of Stay',
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
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          dharmshalaForm.addEnquiry(
                              fullName.text,
                              email.text,
                              dateController.text,
                              tourDetails.text,
                              duration.text,
                              person.text, mobile.text,widget.type);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ])));
      },
    );
  }
}
