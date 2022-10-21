import 'package:dharmlok/constants/AppAssets.dart';
import 'package:dharmlok/constants/AppStrings.dart';
import 'package:dharmlok/viewModels/audio_list_view_model.dart';
import 'package:dharmlok/viewModels/bal_vidya_view_model.dart';
import 'package:dharmlok/viewModels/dharmshala_view_model.dart';
import 'package:dharmlok/viewModels/dharshan_view_model.dart';
import 'package:dharmlok/viewModels/ebook_view_model.dart';
import 'package:dharmlok/viewModels/eshop_view_model.dart';
import 'package:dharmlok/viewModels/event_view_model.dart';
import 'package:dharmlok/viewModels/home_page_view_model.dart';
import 'package:dharmlok/viewModels/pooja_view_model.dart';
import 'package:dharmlok/viewModels/temple_view_model.dart';
import 'package:dharmlok/views/BalvidyaPage/balvidya_page_widget.dart';
import 'package:dharmlok/views/DharamshalaPage/dharamshala_page_widget.dart';
import 'package:dharmlok/views/DharmguruPage/dharmguru_page_widget.dart';
import 'package:dharmlok/views/DharshanPage/dharshan_page_widget.dart';
import 'package:dharmlok/views/ELibraryPageWidget/e_library_page_widget.dart';
import 'package:dharmlok/views/EShopPage/eshop_page_widget.dart';
import 'package:dharmlok/views/EventBookingPage/event_booking_page_widget.dart';
import 'package:dharmlok/views/KathavachakPage/kathavachak_page_widget.dart';
import 'package:dharmlok/views/PanchangPage/panchang_page_widget.dart';
import 'package:dharmlok/views/PoojaPage/pooja_page_widget.dart';
import 'package:dharmlok/views/Temples/temples_page_widget.dart';
import 'package:dharmlok/widgets/background_image_widget.dart';
import 'package:dharmlok/widgets/background_overlay_widget.dart';
import 'package:dharmlok/widgets/drawer_widget.dart';
import 'package:dharmlok/widgets/home_container_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../viewModels/vendor_view_model.dart';
import '../AudioPage/audio_page_widget.dart';
import 'components/home_appbar_widget.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<HomePageViewModel>(context, listen: false).getUserLocation();
    return Consumer<HomePageViewModel>(builder: (con, homeModel, _) {
      return Scaffold(
        key: _key,
        drawer: const DrawerWidget(),
        body: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            SafeArea(
              child: Column(
                children: [
                  HomePageAppBarWidget(
                    scaffoldKey: _key,
                    location: homeModel.userLocation,
                    languageButtonPressed: () {},
                    logoutPressed: () {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeContainerTileWidget(
                                    imageName: AppAssets.dharmaGuruImageWhite,
                                    imageText: AppStrings.dharmaGuru,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              VendorViewModel>>[
                                                        ChangeNotifierProvider<
                                                                VendorViewModel>(
                                                            create: (_) =>
                                                                VendorViewModel())
                                                      ],
                                                      child:
                                                          DharmguruPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.kathavachakImageWhite,
                                    imageText: AppStrings.kathavachak,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              VendorViewModel>>[
                                                        ChangeNotifierProvider<
                                                                VendorViewModel>(
                                                            create: (_) =>
                                                                VendorViewModel())
                                                      ],
                                                      child:
                                                          KathavachakPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.templeImageWhite,
                                    imageText: AppStrings.temple,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              TempleViewModel>>[
                                                        ChangeNotifierProvider<
                                                                TempleViewModel>(
                                                            create: (_) =>
                                                                TempleViewModel())
                                                      ],
                                                      child:
                                                          TemplePageWidget())));
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeContainerTileWidget(
                                    imageName: AppAssets.balVidyaImageWhite,
                                    imageText: AppStrings.balVidya,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(providers: <
                                                      ChangeNotifierProvider<
                                                          BalVidyaViewModel>>[
                                                    ChangeNotifierProvider<
                                                            BalVidyaViewModel>(
                                                        create: (_) =>
                                                            BalVidyaViewModel())
                                                  ], child: BalVidyaPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.audioImageWhite,
                                    imageText: AppStrings.audioLibrary,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              AudioListViewModel>>[
                                                        ChangeNotifierProvider<
                                                            AudioListViewModel>(
                                                            create: (_) =>
                                                                AudioListViewModel())
                                                      ],
                                                      child:
                                                      AudioPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.eLibraryImageWhite,
                                    imageText: AppStrings.eLibrary,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              EbookViewModel>>[
                                                        ChangeNotifierProvider<
                                                                EbookViewModel>(
                                                            create: (_) =>
                                                                EbookViewModel())
                                                      ],
                                                      child:
                                                          ELibraryPageWidget())));
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeContainerTileWidget(
                                    imageName: AppAssets.eventImageWhite,
                                    imageText: AppStrings.eventBooking,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(
                                                      providers: <
                                                          ChangeNotifierProvider<
                                                              EventViewModel>>[
                                                        ChangeNotifierProvider<
                                                                EventViewModel>(
                                                            create: (_) =>
                                                                EventViewModel())
                                                      ],
                                                      child:
                                                          EventBookingPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.poojaImageWhite,
                                    imageText: AppStrings.bookPooja,
                                    onPressed: () {
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
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.dharmshalaImageWhite,
                                    imageText: AppStrings.dharmshala,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(providers: <
                                                      ChangeNotifierProvider<
                                                          DharmshalaViewModel>>[
                                                    ChangeNotifierProvider<
                                                            DharmshalaViewModel>(
                                                        create: (_) =>
                                                            DharmshalaViewModel())
                                                  ], child: DharamshalaPageWidget())));
                                    })
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeContainerTileWidget(
                                    imageName: AppAssets.eshopImageWhite,
                                    imageText: AppStrings.eshop,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(providers: <
                                                      ChangeNotifierProvider<
                                                          EshopViewModel>>[
                                                    ChangeNotifierProvider<
                                                            EshopViewModel>(
                                                        create: (_) =>
                                                            EshopViewModel())
                                                  ], child: EShopPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.dharshanImageWhite,
                                    imageText: AppStrings.liveDharshan,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MultiProvider(providers: <
                                                      ChangeNotifierProvider<
                                                          DharshanViewModel>>[
                                                    ChangeNotifierProvider<
                                                            DharshanViewModel>(
                                                        create: (_) =>
                                                            DharshanViewModel())
                                                  ], child: DharshanPageWidget())));
                                    }),
                                HomeContainerTileWidget(
                                    imageName: AppAssets.panchangImageWhite,
                                    imageText: AppStrings.dailyPanchang,
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PanchangPageWidget()))),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Container(
                              width: context.width,
                              height: context.height * 0.07,
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      'Today\'s Aarti',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow,
                                        elevation: 0),
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
