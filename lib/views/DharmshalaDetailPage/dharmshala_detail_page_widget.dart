import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/dharmshala_form_view_model.dart';
import 'package:dharmlok/views/DharmshalaFormPage/dharmshala_form_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class DharmshalaDetailsPageWidget extends StatelessWidget {
  DharmshalaDetailsPageWidget(
      {required this.dharmshalaName,
      required this.imageLink,
      required this.description,
      required this.location,
        required this.userLocation,
        required this.latitude,
        required this.longitude,
      Key? key})
      : super(key: key);

  final GlobalKey<ScaffoldState> _dharmshalaPageKey = GlobalKey();

  final String dharmshalaName;
  final List<String> imageLink;
  final String location;
  final String description;
  final String userLocation;
  final String latitude;
  final String longitude;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(8.5164032, 76.9359872);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _add() {
    var markerIdVal = Random().nextInt(1002).toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(latitude),
        double.parse(longitude)
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );
    markers[markerId] = marker;
  }

  @override
  Widget build(BuildContext context) {
    _add();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            Column(
              children: [
                HomePageAppBarWidget(
                  scaffoldKey: _dharmshalaPageKey,
                  location: userLocation,
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          dharmshalaName,
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
                        items: imageLink
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
                          location,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.white70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Html(
                                  data : description,
                                ),
                              ),
                            ],
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
                              target: latitude == ''? _center
                                  :LatLng(double.parse(latitude), double.parse(longitude)),
                              zoom: 5.0,
                            ),
                            markers: Set<Marker>.of(
                                markers.values
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
                          child:
                          Padding(
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
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MultiProvider(
                                                    providers: <
                                                        ChangeNotifierProvider<
                                                            DharmshalaFormPageViewModel>>[
                                                      ChangeNotifierProvider<
                                                          DharmshalaFormPageViewModel>(
                                                          create: (_) =>
                                                              DharmshalaFormPageViewModel())
                                                    ],
                                                    child:
                                                    const DharmshalaFormPageWidget(type: 'dharmshala',))));
                                  },
                                  style:
                                  ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.red),
                                  child: const Text(
                                    'BOOK NOW',
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
  }
}
