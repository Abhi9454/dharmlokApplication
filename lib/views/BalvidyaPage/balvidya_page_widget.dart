import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/bal_vidya_view_model.dart';
import 'package:dharmlok/views/PdfViewer/pdf_viewer_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class BalVidyaPageWidget extends StatelessWidget {
  BalVidyaPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _balVidyaKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<BalVidyaViewModel>(context, listen: false).getUserLocation();
    Provider.of<BalVidyaViewModel>(context, listen: false).getBalVidya();
    return Consumer<BalVidyaViewModel>(builder: (con, balModel, _) {
      return Scaffold(
        key: _balVidyaKey,
        body: SafeArea(
          child: Stack(
            children: [
              const BackgroundImageWidget(),
              const BackgroundOverlayWidget(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomePageAppBarWidget(
                    scaffoldKey: _balVidyaKey,
                    location: balModel.userLocation,
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
                        AssetImage(AppAssets.balVidyaImageWhite),
                        color: Colors.brown,
                        size: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          AppStrings.balVidya,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => balModel.updateCategory('Sanatan'),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            color: balModel.category == 'Sanatan'
                                ? Colors.orange
                                : Colors.yellow,
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
                        onTap: () => balModel.updateCategory('Buddhism'),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            color: balModel.category == 'Buddhism'
                                ? Colors.orange
                                : Colors.yellow,
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
                        onTap: () => balModel.updateCategory('Sikh'),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            color: balModel.category == 'Sikh'
                                ? Colors.orange
                                : Colors.yellow,
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
                        onTap: () => balModel.updateCategory('Jain'),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            color: balModel.category == 'Jain'
                                ? Colors.orange
                                : Colors.yellow,
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
                  balModel.status == Status.loading
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : balModel.status == Status.error
                          ? Center(
                              child: Text(
                              balModel.error.message.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ))
                          : balModel.balVidyaDetails.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text('No Record Found'),
                                  ),
                                )
                              : SizedBox(
                                  height: context.height * 0.7,
                                  child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: balModel.balVidyaDetails.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.3),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0,
                                            right: 8.0,
                                            bottom: 12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.brown,
                                                  width: 8.0),
                                              color: AppColors.onPrimary),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  'https://www.dharmlok.com/view/${balModel.balVidyaDetails[index].thumbNailImageUrl}',
                                                  fit: BoxFit.cover,
                                                  height: context.height * 0.2,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    balModel
                                                        .balVidyaDetails[index]
                                                        .name,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            PdfViewPageWidget(
                                                                pdfName: balModel
                                                                    .balVidyaDetails[
                                                                        index]
                                                                    .name,
                                                                pdfLink: balModel
                                                                    .balVidyaDetails[
                                                                        index]
                                                                    .PDFuploadUrl)));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                  child: const Text(
                                                    'READ',
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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //
                  //     ],
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
