import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class TempleDetailPageWidget extends StatefulWidget {
  const TempleDetailPageWidget(
      {required this.templeName,
      required this.imageLink,
      required this.description,
      required this.location,
      required this.city,
      required this.state,
      required this.userLocation,
        required this.latitude,
        required this.longitude,
      Key? key})
      : super(key: key);

  final String templeName;
  final List<String> imageLink;
  final String location;
  final String description;
  final String city;
  final String state;
  final String userLocation;
  final String latitude;
  final String longitude;

  @override
  State<TempleDetailPageWidget> createState() => _TempleDetailPageWidgetState();
}

class _TempleDetailPageWidgetState extends State<TempleDetailPageWidget> {
  final GlobalKey<ScaffoldState> _templeDetailsPageKey = GlobalKey();

  late final GoogleMapController mapController;

  final LatLng _center = const LatLng(8.5164032, 76.9359872);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController person = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController tourDetails = TextEditingController();

  TextEditingController duration = TextEditingController();

  TextEditingController dateController = TextEditingController();

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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            Column(
              children: [
                HomePageAppBarWidget(
                  scaffoldKey: _templeDetailsPageKey,
                  location: widget.userLocation,
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
                      width: context.width * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          widget.templeName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
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
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true, enableInfiniteScroll: true),
                        items: widget.imageLink
                            .map((item) => SizedBox(
                                  child: Center(
                                      child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: context.width * 0.7,
                                    height: context.height * 0.6,
                                  )),
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          '${widget.city},${widget.state}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 22,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black54, width: 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            // child: Text(
                            //   description,
                            //   textAlign: TextAlign.center,
                            //   maxLines: 500,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: const TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.normal),
                            // ),
                            child: Html(data: widget.description),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: context.width,
                          height: context.height * 0.5,
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: widget.latitude == ''? _center
                                  :LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
                              zoom: 11.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.brown,
                          width: context.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    'How it works?',
                                    textAlign: TextAlign.center,
                                    maxLines: 15,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Tell us details of your holiday plan.',
                                    textAlign: TextAlign.center,
                                    maxLines: 15,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
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
                                                              controller: email,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          'Email',
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
                                                                      'Travel Dates',
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
                                                                  tourDetails,
                                                              maxLines: 5,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          'Tour Description',
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
                                                              controller: person,
                                                              maxLines: 1,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          'Number of Person',
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
                                                                  duration,
                                                              maxLines: 1,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          'Duration of Stay',
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
                                                          )
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
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text(
                                    'BOOK NOW',
                                    style: TextStyle(color: Colors.white),
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
  }
}
