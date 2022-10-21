import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class PanchangPageWidget extends StatelessWidget {
  PanchangPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _panchangPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _panchangPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            Column(
              children: [
                HomePageAppBarWidget(
                  scaffoldKey: _panchangPageKey,
                  location: 'New Delhi',
                  languageButtonPressed: () {},
                  logoutPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_ios)),
                          const ImageIcon(
                            AssetImage(AppAssets.panchangImageWhite),
                            color: Colors.brown,
                            size: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              AppStrings.dailyPanchang,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.height * 0.06,
                      ),
                      Stack(
                        children: [
                          Image.asset('images/dashboard.jpeg',
                              width: context.width,
                              fit: BoxFit.cover,
                              height: context.height * 0.28),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Date : 08/09/2022',
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: context.height * 0.01,),
                                const Text(
                                  'Tithi : Chaturthi',
                                  style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                                ,
                                SizedBox(height: context.height * 0.01,),
                                const Text(
                                  'Yoga : Parigrah',
                                  style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                                ,
                                SizedBox(height: context.height * 0.01,),
                                const Text(
                                  'Nakshatra : Poorva Phalguni',
                                  style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                                ,
                                SizedBox(height: context.height * 0.01,),
                                const Text(
                                  'Sunrise : 09/08/2022 5:32:22',
                                  style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                                ,
                                SizedBox(height: context.height * 0.01,),
                                const Text(
                                  'Sunset : 09/08/2022 18:32:22',
                                  style: TextStyle(
                                      color: AppColors.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
