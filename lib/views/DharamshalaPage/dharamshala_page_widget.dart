import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/dharmshala_view_model.dart';
import 'package:dharmlok/views/DharmshalaDetailPage/dharmshala_detail_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class DharamshalaPageWidget extends StatelessWidget {
  DharamshalaPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _dharamshalaPageWidget = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<DharmshalaViewModel>(context, listen: false).getDharmshala();
    return Consumer<DharmshalaViewModel>(
      builder: (con, dharmshalaModel, _) {
        return Scaffold(
          key: _dharamshalaPageWidget,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _dharamshalaPageWidget,
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
                            icon: const Icon(Icons.arrow_back_ios)),
                        const ImageIcon(
                          AssetImage(AppAssets.dharmshalaImageWhite),
                          color: Colors.brown,
                          size: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.dharmshala,
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
                      height: context.height * 0.02,
                    ),
                    dharmshalaModel.status == Status.loading
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : dharmshalaModel.status == Status.error
                            ? Expanded(
                                child: Center(
                                    child: Text(
                                  dharmshalaModel.error.message.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                )),
                              )
                            : dharmshalaModel.dharmshalaList.isEmpty
                                ? const Expanded(
                                    child: Center(
                                      child: Text('No Record Found'),
                                    ),
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          dharmshalaModel.dharmshalaList.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.1),
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 12.0),
                                          child: Container(
                                            decoration:BoxDecoration(
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
                                                    '${AppStrings.imageUrl}${dharmshalaModel.dharmshalaList[index].bannerImageUrl}',
                                                    fit: BoxFit.cover,
                                                    height:
                                                        context.height * 0.2,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      dharmshalaModel
                                                          .dharmshalaList[index]
                                                          .name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${dharmshalaModel.dharmshalaList[index].city},${dharmshalaModel.dharmshalaList[index].state}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      List<String> imageLinks =
                                                          [];
                                                      imageLinks.add(
                                                          '${AppStrings.imageUrl}${dharmshalaModel.dharmshalaList[index].bannerImageUrl}');
                                                      imageLinks.add(
                                                          '${AppStrings.imageUrl}${dharmshalaModel.dharmshalaList[index].relatedImageUrl}');
                                                      String location =
                                                          '${dharmshalaModel.dharmshalaList[index].city},${dharmshalaModel.dharmshalaList[index].state}';
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DharmshalaDetailsPageWidget(
                                                                    dharmshalaName: dharmshalaModel
                                                                        .dharmshalaList[
                                                                            index]
                                                                        .name,
                                                                    imageLink:
                                                                        imageLinks,
                                                                    location:
                                                                        location,
                                                                    description: dharmshalaModel
                                                                        .dharmshalaList[
                                                                            index]
                                                                        .description,
                                                                  )));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    child: const Text(
                                                      'EXPLORE',
                                                      style: TextStyle(
                                                          color: Colors.white),
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
