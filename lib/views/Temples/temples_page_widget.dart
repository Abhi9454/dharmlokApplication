import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/temple_view_model.dart';
import 'package:dharmlok/views/TempleDetailPage/temple_detail_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class TemplePageWidget extends StatelessWidget {
  TemplePageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _templeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<TempleViewModel>(context, listen: false).getUserLocation();
    Provider.of<TempleViewModel>(context, listen: false).getAllTemples();
    return Consumer<TempleViewModel>(
      builder: (con, templeModel, _) {
        return Scaffold(
          key: _templeKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _templeKey,
                      location: templeModel.userLocation,
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
                          AssetImage(AppAssets.templeImageWhite),
                          color: Color(0XFF604e36),
                          size: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.temple,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0XFF604e36),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => templeModel.updateCategory('Sanatan'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Color(0XFF604e36)),
                              color: templeModel.category == 'Sanatan'
                                  ? Colors.white70
                                  : Colors.white30,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Sanatan'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => templeModel.updateCategory('Buddhism'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Color(0XFF604e36)),
                              color: templeModel.category == 'Buddhism'
                                  ? Colors.white70
                                  : Colors.white30,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Buddhism',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => templeModel.updateCategory('Sikh'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Color(0XFF604e36)),
                              color: templeModel.category == 'Sikh'
                                  ? Colors.white70
                                  : Colors.white30,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Sikh'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => templeModel.updateCategory('Jain'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Color(0XFF604e36)),
                              color: templeModel.category == 'Jain'
                                  ? Colors.white70
                                  : Colors.white30,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Jain'),
                              ),
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
                                    color: Color(0XFF604e36),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            templeModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : templeModel.status == Status.error
                                    ? Center(
                                        child: Text(
                                        templeModel.error.message.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ))
                                    : templeModel.myTempleList.isNotEmpty
                                        ? SizedBox(
                                            height: context.height * 0.38,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: templeModel
                                                  .myTempleList.length,
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                  width: context.width * 0.6,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            bottom: 12.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          // border: Border.all(
                                                          //     color:
                                                          //         Color(0XFF604e36),
                                                          //     width: 8.0),
                                                          color: Colors.white60),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Image.network(
                                                              '${AppStrings.imageUrl}${templeModel.myTempleList[index].bannerImageUrl}',
                                                              fit: BoxFit
                                                                  .contain,
                                                              height: context
                                                                      .height *
                                                                  0.2,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                templeModel
                                                                    .myTempleList[
                                                                        index]
                                                                    .name,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                List<String>
                                                                    imageLinks =
                                                                    [];
                                                                imageLinks.add(
                                                                    '${AppStrings.imageUrl}${templeModel.otherTempleList[index].bannerImageUrl}');
                                                                imageLinks.add(
                                                                    '${AppStrings.imageUrl}${templeModel.otherTempleList[index].relatedImageUrl}');
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => TempleDetailPageWidget(
                                                                              templeName: templeModel.otherTempleList[index].name,
                                                                              imageLink: imageLinks,
                                                                              description: templeModel.otherTempleList[index].description,
                                                                              location: templeModel.otherTempleList[index].location,
                                                                              city: templeModel.otherTempleList[index].city,
                                                                              state: templeModel.otherTempleList[index].state,
                                                                              userLocation: templeModel.userLocation,
                                                                            )));
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
                                    color: Color(0XFF604e36),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            templeModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : templeModel.otherTempleList.isNotEmpty
                                    ? SizedBox(
                                        height: context.height * 0.38,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: templeModel
                                              .otherTempleList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return SizedBox(
                                              width: context.width * 0.6,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8.0,
                                                    bottom: 12.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      // border: Border.all(
                                                      //     color: Color(0XFF604e36),
                                                      //     width: 8.0),
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      color:
                                                          Colors.white60),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Image.network(
                                                          '${AppStrings.imageUrl}${templeModel.otherTempleList[index].bannerImageUrl}',
                                                          fit: BoxFit.contain,
                                                          height:
                                                              context.height *
                                                                  0.2,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            templeModel
                                                                .otherTempleList[
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
                                                            List<String>
                                                                imageLinks = [];
                                                            imageLinks.add(
                                                                '${AppStrings.imageUrl}${templeModel.otherTempleList[index].bannerImageUrl}');
                                                            imageLinks.add(
                                                                '${AppStrings.imageUrl}${templeModel.otherTempleList[index].relatedImageUrl}');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TempleDetailPageWidget(
                                                                              templeName: templeModel.otherTempleList[index].name,
                                                                              imageLink: imageLinks,
                                                                              description: templeModel.otherTempleList[index].description,
                                                                              location: templeModel.otherTempleList[index].location,
                                                                              city: templeModel.otherTempleList[index].city,
                                                                              state: templeModel.otherTempleList[index].state,
                                                                              userLocation: templeModel.userLocation,
                                                                            )));
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
