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
import 'package:dharmlok/views/AartiPage/aarti_page_widget.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../viewModels/vendor_view_model.dart';
import '../AudioPage/audio_page_widget.dart';
import 'components/home_appbar_widget.dart';

class HomePageWidget extends StatelessWidget {
  HomePageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();


  Future<void> _launchInBrowser() async {
    if (!await launchUrl(
      Uri.parse('https://www.dharmlok.in'),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch';
    }
  }

  List<String> religionList= ['Sanatan','Buddhism','Sikh', 'Jain'];


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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeContainerTileWidget(
                                  imageName: AppAssets.dharmaGuruImage,
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
                                  imageName: AppAssets.kathavachakImage,
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
                                  imageName: AppAssets.templeImage,
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
                              left: 10.0, right: 10.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeContainerTileWidget(
                                  imageName: AppAssets.balVidyaImage,
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
                                  imageName: AppAssets.audioImage,
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
                                  imageName: AppAssets.eLibraryImage,
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
                              left: 10.0, right: 10.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeContainerTileWidget(
                                  imageName: AppAssets.eventImage,
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
                                  imageName: AppAssets.poojaImage,
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
                                  imageName: AppAssets.dharmshalaImage,
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
                              left: 10.0, right: 10.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              HomeContainerTileWidget(
                                  imageName: AppAssets.eshopImage,
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
                                  imageName: AppAssets.dharshanImage,
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
                                  imageName: AppAssets.panchangImage,
                                  imageText: AppStrings.dailyPanchang,
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PanchangPageWidget(userLocation: homeModel.userLocation,)))),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: HomeContainerTileWidget(
                                imageName: AppAssets.travelImage,
                                imageText: 'Travel',
                                onPressed: () => _launchInBrowser()),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: Container(
                            width: context.width,
                            height: context.height * 0.06,
                            color: const Color(0XFFa60606),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'Today\'s Aarti',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(child: Text('Select')),
                                            content: SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.4, // Change as per your requirement
                                              width: MediaQuery.of(context).size.width * 0.6, // Change as per your requirement
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: religionList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).pop();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const AartiPageWidget()),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Card(
                                                        child: ListTile(
                                                          title: Text(religionList[index]),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      elevation: 0),
                                  child: const Text(
                                    'Start',
                                    style: TextStyle(
                                        color: Color(0XFF604e36),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
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
