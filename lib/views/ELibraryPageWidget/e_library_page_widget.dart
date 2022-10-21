import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/ebook_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';
import '../PdfViewer/pdf_viewer_page_widget.dart';

class ELibraryPageWidget extends StatelessWidget {
  ELibraryPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _eLibraryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<EbookViewModel>(context, listen: false).getTrendingEbook();
    Provider.of<EbookViewModel>(context, listen: false).getDevotionEbook();
    Provider.of<EbookViewModel>(context, listen: false).getFictionEbook();
    return Consumer<EbookViewModel>(
      builder: (con, ebookModel, _) {
        return Scaffold(
          key: _eLibraryKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _eLibraryKey,
                      location: 'New Delhi',
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
                          AssetImage(AppAssets.eLibraryImageWhite),
                          color: Colors.brown,
                          size: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.eLibrary,
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
                          onTap: () => ebookModel.updateCategory('Sanatan'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: ebookModel.category == 'Sanatan'
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
                          onTap: () => ebookModel.updateCategory('Buddhism'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: ebookModel.category == 'Buddhism'
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
                          onTap: () => ebookModel.updateCategory('Sikh'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: ebookModel.category == 'Sikh'
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
                          onTap: () => ebookModel.updateCategory('Jain'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: ebookModel.category == 'Jain'
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
                                'Trending eBooks',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ebookModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : ebookModel.status == Status.error
                                    ? Center(
                                        child: Text(
                                        ebookModel.error.message.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ))
                                    : ebookModel.ebookTrendingList.isNotEmpty
                                        ? SizedBox(
                                            height: context.height * 0.38,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: ebookModel
                                                  .ebookTrendingList.length,
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
                                                        border: Border.all(
                                                            color: Colors.brown,
                                                            width: 8.0),
                                                        color: AppColors
                                                            .onPrimary),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                            'https://www.dharmlok.com/view/${ebookModel.ebookTrendingList[index].thumbNailImageUrl}',
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
                                                              ebookModel
                                                                  .ebookTrendingList[
                                                                      index]
                                                                  .name,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                  builder: (context) => PdfViewPageWidget(
                                                                      pdfName: ebookModel
                                                                          .ebookTrendingList[
                                                                              index]
                                                                          .name,
                                                                      pdfLink: ebookModel
                                                                          .ebookTrendingList[
                                                                              index]
                                                                          .pdFuploadUrl)));
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                            child: const Text(
                                                              'READ',
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
                                'Devotional eBooks',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ebookModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : ebookModel.ebookDevotionList.isNotEmpty
                                    ? SizedBox(
                                        height: context.height * 0.38,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ebookModel
                                              .ebookDevotionList.length,
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
                                                    border: Border.all(
                                                        color: Colors.brown,
                                                        width: 8.0),
                                                    color: AppColors.onPrimary),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        'https://www.dharmlok.com/view/${ebookModel.ebookDevotionList[index].thumbNailImageUrl}',
                                                        fit: BoxFit.cover,
                                                        height: context.height *
                                                            0.2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          ebookModel
                                                              .ebookDevotionList[
                                                                  index]
                                                              .name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => PdfViewPageWidget(
                                                                  pdfName: ebookModel
                                                                      .ebookDevotionList[
                                                                          index]
                                                                      .name,
                                                                  pdfLink: ebookModel
                                                                      .ebookDevotionList[
                                                                          index]
                                                                      .pdFuploadUrl)));
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        child: const Text(
                                                          'READ',
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
                            const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Fiction eBooks',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ebookModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : ebookModel.ebookFictionList.isNotEmpty
                                    ? SizedBox(
                                        height: context.height * 0.38,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ebookModel
                                              .ebookFictionList.length,
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
                                                    border: Border.all(
                                                        color: Colors.brown,
                                                        width: 8.0),
                                                    color: AppColors.onPrimary),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Image.network(
                                                        'https://www.dharmlok.com/view/${ebookModel.ebookFictionList[index].thumbNailImageUrl}',
                                                        fit: BoxFit.cover,
                                                        height: context.height *
                                                            0.2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          ebookModel
                                                              .ebookFictionList[
                                                                  index]
                                                              .name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => PdfViewPageWidget(
                                                                  pdfName: ebookModel
                                                                      .ebookFictionList[
                                                                          index]
                                                                      .name,
                                                                  pdfLink: ebookModel
                                                                      .ebookFictionList[
                                                                          index]
                                                                      .pdFuploadUrl)));
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        child: const Text(
                                                          'READ',
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