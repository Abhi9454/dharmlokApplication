import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/pooja_view_model.dart';
import 'package:dharmlok/viewModels/temple_view_model.dart';
import 'package:dharmlok/views/PanditDetailsPage/pandit_details_page.dart';
import 'package:dharmlok/views/TempleDetailPage/temple_detail_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../viewModels/pandit_details_view_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class PoojaPageWidget extends StatelessWidget {
  PoojaPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _poojaKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<PoojaViewModel>(context, listen: false).getUserLocation();
    Provider.of<PoojaViewModel>(context, listen: false).getAllPooja();
    return Consumer<PoojaViewModel>(
      builder: (con, poojaModel, _) {
        return Scaffold(
          key: _poojaKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _poojaKey,
                      location: poojaModel.userLocation,
                      languageButtonPressed: () {},
                      logoutPressed: () {},
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios)),
                        const ImageIcon(
                          AssetImage(AppAssets.poojaImageWhite),
                          color: Colors.brown,
                          size: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.bookPooja,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 30,
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
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'In your city',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            poojaModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : poojaModel.status == Status.error
                                    ? Center(
                                        child: Text(
                                        poojaModel.error.message.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ))
                                    : poojaModel.myPoojaList.isNotEmpty
                                        ? SizedBox(
                                            height: context.height * 0.38,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  poojaModel.myPoojaList.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                          bottom: 12.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color: Colors.brown,
                                                      //     width: 8.0),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        color: Colors.white70),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                            '${AppStrings.imageUrl}${poojaModel.myPoojaList[index].profileImageUrl}',
                                                            fit: BoxFit.cover,
                                                            height:
                                                                context.height *
                                                                    0.2,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              poojaModel
                                                                  .myPoojaList[
                                                                      index]
                                                                  .name,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          MultiProvider(
                                                                              providers: <
                                                                                  ChangeNotifierProvider<
                                                                                      PanditDetailsViewModel>>[
                                                                                ChangeNotifierProvider<
                                                                                    PanditDetailsViewModel>(
                                                                                    create: (_) =>
                                                                                        PanditDetailsViewModel())
                                                                              ],
                                                                              child:
                                                                              PanditDetailsPageWidget(panditId:   poojaModel
                                                                                  .myPoojaList[
                                                                              index]
                                                                                  .id, phoneNumber: poojaModel
                                                                                  .myPoojaList[
                                                                              index]
                                                                                  .phone,))));
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                            child: const Text(
                                                              'EXPLORE',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: context.height * 0.2,
                                            child: const Center(
                                              child: Text('No Record Found'),
                                            ),
                                          ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'In Other City',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            poojaModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : poojaModel.otherPoojaList.isNotEmpty
                                    ? SizedBox(
                                        height: context.height * 0.38,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              poojaModel.otherPoojaList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  bottom: 12.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // border: Border.all(
                                                  //     color: Colors.brown,
                                                  //     width: 8.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.white70),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        '${AppStrings.imageUrl}${poojaModel.otherPoojaList[index].profileImageUrl}',
                                                        fit: BoxFit.cover,
                                                        height: context.height *
                                                            0.2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          poojaModel
                                                              .otherPoojaList[
                                                                  index]
                                                              .name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MultiProvider(
                                                                          providers: <
                                                                              ChangeNotifierProvider<
                                                                                  PanditDetailsViewModel>>[
                                                                            ChangeNotifierProvider<
                                                                                PanditDetailsViewModel>(
                                                                                create: (_) =>
                                                                                    PanditDetailsViewModel())
                                                                          ],
                                                                          child:
                                                                          PanditDetailsPageWidget(panditId:poojaModel
                                                                              .otherPoojaList[
                                                                          index]
                                                                              .serviceId, phoneNumber: poojaModel
                                                                              .otherPoojaList[
                                                                          index]
                                                                              .phone,))));
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        child: const Text(
                                                          'EXPLORE',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox(
                                        height: context.height * 0.2,
                                        child: const Center(
                                          child: Text('No Record Found'),
                                        ),
                                      ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    )
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
