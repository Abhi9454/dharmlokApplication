import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/pandit_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../helpers/read_user_data.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';


class PanditDetailsPageWidget extends StatefulWidget {
  PanditDetailsPageWidget({Key? key, required this.panditId, required this.phoneNumber}) : super(key: key);

  final String panditId;
  final String phoneNumber;

  @override
  State<PanditDetailsPageWidget> createState() => _PanditDetailsPageWidgetState();
}

class _PanditDetailsPageWidgetState extends State<PanditDetailsPageWidget> {
  final GlobalKey<ScaffoldState> _panditDetailsPage = GlobalKey();

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

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

  @override
  Widget build(BuildContext context) {
    Provider.of<PanditDetailsViewModel>(context,listen: false).getPanditDetails(widget.panditId);
    return Consumer<PanditDetailsViewModel>(
      builder: (con, panditDetailsModel, _){
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                panditDetailsModel.status == Status.loading ?
                const Center(child: CircularProgressIndicator(),) :
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _panditDetailsPage,
                      location: panditDetailsModel.userLocation,
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
                        SizedBox(
                          width: context.width * 0.8,
                          child: Text(
                            panditDetailsModel.panditDetails.message.name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.network(
                                  '${AppStrings.imageUrl}${panditDetailsModel.panditDetails.message.imageUrl}',
                                  fit: BoxFit.contain,
                                  height: context.height * 0.35,
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  panditDetailsModel.panditDetails.message.services,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  'Location : ${panditDetailsModel.panditDetails.message.city}, ${panditDetailsModel.panditDetails.message.state}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  'Service Available : ${panditDetailsModel.panditDetails.message.type == 'Both' ? 'Online and Offline' : panditDetailsModel.panditDetails.message.type == 'Online' ? 'Online' : 'Offline'}',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  //color: Colors.brown,
                                  width: context.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          color: Colors.white70,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10.0, right: 10.0),
                                              // child: Text(
                                              //   biography,
                                              //   textAlign: TextAlign.justify,
                                              //   style: const TextStyle(
                                              //       color:
                                              //           AppColors.onPrimary,
                                              //       fontSize: 15),
                                              // ),
                                              child: Html(
                                                data: panditDetailsModel.panditDetails.message.description,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Container(
                                  color: Colors.white70,
                                  width: context.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'Package : Rs. ${panditDetailsModel.panditDetails.message.price}',
                                            textAlign: TextAlign.center,
                                            maxLines: 15,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        SizedBox(
                                          height: context.height * 0.001,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async{
                                            String name = await UserDetails().getUserFullName();
                                            var url = 'https://wa.me/+91${widget.phoneNumber}?text=HI%20${panditDetailsModel.panditDetails.message.name}%2C%0A%0ANeed%20Shradha%20of%20%20Amount%20${panditDetailsModel.panditDetails.message.price}%20Link%Pooja%20https://dharmlok.com/#/events-booking/puja-detail?id=${panditDetailsModel.panditDetails.message.id}';
                                            _launchInBrowser(Uri.parse(url));
                                          },
                                          style:
                                          ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.red),
                                          child: const Text(
                                            'Contact Pandit',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: context.height * 0.001,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async{
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Dialog(
                                                      insetPadding:
                                                      const EdgeInsets.all(5.0),
                                                      child: SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            const Padding(
                                                              padding:
                                                              EdgeInsets.all(12.0),
                                                              child: Text(
                                                                'Enter Details',
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
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
                                                                    child: InkWell(
                                                                      onTap: (){
                                                                        _selectDate(context);
                                                                      },
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
                                                                        const InputDecoration(
                                                                          prefixIcon: Icon(Icons.date_range),
                                                                          hintText:
                                                                          'Pooja Dates',
                                                                          enabledBorder:
                                                                          OutlineInputBorder(
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
                                                                          OutlineInputBorder(
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
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed: () {},
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
                                                                        ElevatedButton(
                                                                          onPressed: () {

                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          style: ElevatedButton
                                                                              .styleFrom(
                                                                              backgroundColor:
                                                                              Colors
                                                                                  .red),
                                                                          child: const Text(
                                                                            'Close',
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .white),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          style:
                                          ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.red),
                                          child: const Text(
                                            'Customize Enquire',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
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
