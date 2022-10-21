import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class DharmshalaDetailsPageWidget extends StatelessWidget {
  DharmshalaDetailsPageWidget(
      {required this.dharmshalaName,
      required this.imageLink,
      required this.description,
      required this.location,
      Key? key})
      : super(key: key);

  final GlobalKey<ScaffoldState> _dharmshalaPageKey = GlobalKey();

  final String dharmshalaName;
  final List<String> imageLink;
  final String location;
  final String description;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(8.5164032, 76.9359872);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                  scaffoldKey: _dharmshalaPageKey,
                  location: 'New Delhi',
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
                          color: Colors.brown,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  description,
                                  textAlign: TextAlign.center,
                                  maxLines: 15,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
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
                              target: _center,
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
