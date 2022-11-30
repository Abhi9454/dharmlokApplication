import '../extensions/device_size.dart';
import '../viewModels/dharmshala_view_model.dart';
import '../viewModels/eshop_view_model.dart';
import '../viewModels/event_view_model.dart';
import '../views/DharamshalaPage/dharamshala_page_widget.dart';
import '../views/EShopPage/eshop_page_widget.dart';
import '../views/EventBookingPage/event_booking_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/AppAssets.dart';
import '../constants/AppStrings.dart';
import '../viewModels/bal_vidya_view_model.dart';
import '../viewModels/pooja_view_model.dart';
import '../viewModels/temple_view_model.dart';
import '../viewModels/vendor_view_model.dart';
import '../views/BalvidyaPage/balvidya_page_widget.dart';
import '../views/DharmguruPage/dharmguru_page_widget.dart';
import '../views/KathavachakPage/kathavachak_page_widget.dart';
import '../views/PoojaPage/pooja_page_widget.dart';
import '../views/Temples/temples_page_widget.dart';
import 'drawer_list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = context.width * 0.6;
    return Drawer(
      width: width,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white30,
            ),
            child: Image(
              image: const AssetImage(
                'images/logo.png',
              ),
              fit: BoxFit.contain,
              height: context.height * 0.15,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                              ChangeNotifierProvider<VendorViewModel>>[
                            ChangeNotifierProvider<VendorViewModel>(
                                create: (_) => VendorViewModel())
                          ], child: DharmguruPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.dharmaGuruImage,
                imageText: AppStrings.dharmaGuru),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                              ChangeNotifierProvider<VendorViewModel>>[
                            ChangeNotifierProvider<VendorViewModel>(
                                create: (_) => VendorViewModel())
                          ], child: KathavachakPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.kathavachakImage,
                imageText: AppStrings.kathavachak),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MultiProvider(providers: <
                              ChangeNotifierProvider<
                                  TempleViewModel>>[
                            ChangeNotifierProvider<
                                TempleViewModel>(
                                create: (_) =>
                                    TempleViewModel())
                          ], child: TemplePageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.templeImage, imageText: AppStrings.temple),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                              ChangeNotifierProvider<BalVidyaViewModel>>[
                            ChangeNotifierProvider<BalVidyaViewModel>(
                                create: (_) => BalVidyaViewModel())
                          ], child: BalVidyaPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.balVidyaImage,
                imageText: AppStrings.balVidya),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                              ChangeNotifierProvider<DharmshalaViewModel>>[
                            ChangeNotifierProvider<DharmshalaViewModel>(
                                create: (_) => DharmshalaViewModel())
                          ], child: DharamshalaPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.dharmshalaImage,
                imageText: AppStrings.dharmshala),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                          ChangeNotifierProvider<EventViewModel>>[
                        ChangeNotifierProvider<EventViewModel>(
                            create: (_) => EventViewModel())
                      ], child: EventBookingPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.eventImage,
                imageText: AppStrings.eventBooking),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(providers: <
                              ChangeNotifierProvider<EshopViewModel>>[
                            ChangeNotifierProvider<EshopViewModel>(
                                create: (_) => EshopViewModel())
                          ], child: EShopPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.eshopImage, imageText: AppStrings.eshop),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MultiProvider(providers: <
                              ChangeNotifierProvider<
                                  PoojaViewModel>>[
                            ChangeNotifierProvider<
                                PoojaViewModel>(
                                create: (_) =>
                                    PoojaViewModel())
                          ], child: PoojaPageWidget())));
            },
            child: const DrawerListTileWidget(
                imageName: AppAssets.poojaImage, imageText: AppStrings.bookPooja),
          ),
        ],
      ),
    );
  }
}
