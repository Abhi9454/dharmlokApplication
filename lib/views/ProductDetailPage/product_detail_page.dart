import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/helpers/read_user_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/AppColors.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class ProductDetailPageWidget extends StatefulWidget {
  ProductDetailPageWidget(
      {required this.productName,
        required this.productPrice,
        required this.productImage,
        required this.category,
        required this.availability,
        required this.vendorName,
        required this.vendorPhone,
        required this.productId,
        Key? key})
      : super(key: key);


  final String productName;
  final String productPrice;
  final String category;
  final String productImage;
  final String availability;
  final String vendorName;
  final String vendorPhone;
  final String productId;

  @override
  State<ProductDetailPageWidget> createState() => _ProductDetailPageWidgetState();
}

class _ProductDetailPageWidgetState extends State<ProductDetailPageWidget> {

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  final GlobalKey<ScaffoldState> _dharmshalaPageKey = GlobalKey();

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'Product Details',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
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
                          Image.network(
                            'https://www.dharmlok.com/view/${widget.productImage}',
                            fit: BoxFit.cover,
                            height: context.height * 0.45,
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              widget.productName,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              '₹${widget.productPrice}',
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 22,
                                  fontWeight:
                                  FontWeight.bold),
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
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                        'Availability: ${widget.availability} STOCK',
                                        textAlign: TextAlign.center,
                                        maxLines: 15,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Category: ${widget.category}',
                                        textAlign: TextAlign.center,
                                        maxLines: 15,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Quantity',
                                        textAlign: TextAlign.center,
                                        maxLines: 15,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    QuantityInput(
                                        buttonColor: Colors.orange,
                                        value: quantity,
                                        minValue: 1,
                                        maxValue: 300,
                                        readOnly: true,
                                        inputWidth: context.width * 0.2,
                                        onChanged: (value) => setState(() => quantity = int.parse(value.replaceAll(',', '')))
                                    ),
                                    SizedBox(
                                      height: context.height * 0.02,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async{
                                        String name = await UserDetails().getUserFullName();
                                        var url = 'https://wa.me/+91${widget.vendorPhone}?text=HI%20${widget.vendorName}%2C%0A%0ANeed%20to%20Purchase%20${widget.productName}%20of%20amount%20${widget.productPrice}%20for%20quantity%20$quantity.%20%0A%0AName%3A$name%0AProduct%20Name%3A%20${widget.productName}%0AQuntity%3A%20$quantity%0A%0AThanks%0A%0ALink%20Eshop%3A%20http%3A%2F%2F50.19.104.238%2F%23%2Fe-shop%2Fdetail%3Fid%3D${widget.productId}';
                                        _launchInBrowser(Uri.parse(url));
                                      },
                                      style:
                                      ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Colors.red),
                                      child: const Text(
                                        'Contact',
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

