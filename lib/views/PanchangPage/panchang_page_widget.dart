import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/panchang_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class PanchangPageWidget extends StatelessWidget {
  PanchangPageWidget({required this.userLocation, Key? key}) : super(key: key);

  final String userLocation;

  final GlobalKey<ScaffoldState> _panchangPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<PanchangViewModel>(context, listen: false).getP();
    return Consumer<PanchangViewModel>(builder: (con, pModel, _) {
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
                    location: userLocation,
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
                                  Text(
                                    'Date : ${pModel.pDetail['reqdate']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.01,
                                  ),
                                  Text(
                                    'Tithi : ${pModel.pDetail['tithi']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.01,
                                  ),
                                  Text(
                                    'Yoga : ${pModel.pDetail['yoga']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.01,
                                  ),
                                  Text(
                                    'Nakshatra : ${pModel.pDetail['nakshatra']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.01,
                                  ),
                                  Text(
                                    'Sunrise : ${pModel.pDetail['sunrise']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: context.height * 0.01,
                                  ),
                                  Text(
                                    'Sunset : ${pModel.pDetail['sunset']}',
                                    style: const TextStyle(
                                        color: AppColors.onPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
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
    });
  }
}
