
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class PdfViewPageWidget extends StatefulWidget {
  const PdfViewPageWidget(
      {required this.pdfName, required this.pdfLink, required this.userLocation,Key? key})
      : super(key: key);

  final String pdfName;
  final String pdfLink;
  final String userLocation;

  @override
  State<PdfViewPageWidget> createState() => _PdfViewPageWidgetState();
}

class _PdfViewPageWidgetState extends State<PdfViewPageWidget> {
  final GlobalKey<ScaffoldState> _pdfViewerKey = GlobalKey();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            Column(
              children: [
                HomePageAppBarWidget(
                  scaffoldKey: _pdfViewerKey,
                  location: widget.userLocation,
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
                        icon: const Icon(Icons.arrow_back_ios,size: 20,)),
                    SizedBox(
                      width: context.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        child: Text(
                          widget.pdfName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                Expanded(
                  child: SfPdfViewer.network(
                    'https://dharmlok.s3.amazonaws.com/${widget.pdfLink}',
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
