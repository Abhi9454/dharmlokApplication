import 'package:chewie/chewie.dart';
import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/dharshan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class DharshanPageWidget extends StatefulWidget {
  const DharshanPageWidget({this.nowPlayingName = 'Shree Mahakaleshwar Temple Ujjain', this.nowPlayingUrl = 'https://www.youtube.com/watch?v=Oa5WAluC4rs?modestbranding=1',Key? key}) : super(key: key);

  final String nowPlayingName;
  final String nowPlayingUrl;

  @override
  State<DharshanPageWidget> createState() => _DharshanPageWidgetState();
}

class _DharshanPageWidgetState extends State<DharshanPageWidget> {
  final GlobalKey<ScaffoldState> _dharshanPageKey = GlobalKey();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DharshanViewModel>(context, listen: false).getUserLocation();
    Provider.of<DharshanViewModel>(context, listen: false).getDharshan();
    return Consumer<DharshanViewModel>(
      builder: (con, dharshanModel, _) {
        return Scaffold(
          key: _dharshanPageKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _dharshanPageKey,
                      location: dharshanModel.userLocation,
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
                          AssetImage(AppAssets.dharshanImageWhite),
                          color: Colors.brown,
                          size: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.liveDharshan,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => dharshanModel.updateCategory('Sanatan'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.brown),
                              color: dharshanModel.category == 'Sanatan'
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
                          onTap: () => dharshanModel.updateCategory('Buddhism'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.brown),
                              color: dharshanModel.category == 'Buddhism'
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
                                child: Text('Buddhism'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => dharshanModel.updateCategory('Sikh'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.brown),
                              color: dharshanModel.category == 'Sikh'
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
                          onTap: () => dharshanModel.updateCategory('Jain'),
                          child: Container(
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.brown),
                              color: dharshanModel.category == 'Jain'
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
                    dharshanModel
                        .liveDharshan.isNotEmpty ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YoutubePlayer(
                      controller:
                      YoutubePlayerController(
                          initialVideoId: YoutubePlayer
                              .convertUrlToId(
                              widget.nowPlayingUrl)!,
                          //Add videoID.
                          flags:
                          const YoutubePlayerFlags(
                            hideControls:
                            false,
                            controlsVisibleAtStart:
                            true,
                            autoPlay: false,
                            mute: false,
                          ),
                      ),
                      showVideoProgressIndicator:
                      true,
                      progressIndicatorColor:
                      AppColors
                            .primary,
                    ),
                        ) : const CircularProgressIndicator(),
                    dharshanModel
                        .liveDharshan.isNotEmpty ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                      widget.nowPlayingName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                        ) : const SizedBox(),
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
                                'Live Dharshan',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            dharshanModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : dharshanModel.status == Status.error
                                    ? Center(
                                        child: Text(
                                        dharshanModel.error.message.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ))
                                    : dharshanModel.liveDharshan.isNotEmpty
                                        ? SizedBox(
                                            //height: context.height * 0.38,
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: dharshanModel
                                                  .liveDharshan.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).pop();
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
                                                                ], child: DharshanPageWidget(
                                                                  nowPlayingName: dharshanModel
                                                                      .liveDharshan[index].title,
                                                                  nowPlayingUrl: dharshanModel
                                                                      .liveDharshan[index].url,
                                                                ))));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            bottom: 12.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        // border: Border.all(
                                                        //     color: Colors.brown,
                                                        //     width: 8.0),
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          color: Colors.white70),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Column(
                                                          children: [
                                                            // YoutubePlayer(
                                                            //   controller:
                                                            //       YoutubePlayerController(
                                                            //     initialVideoId: YoutubePlayer
                                                            //         .convertUrlToId(
                                                            //             dharshanModel
                                                            //                 .liveDharshan[
                                                            //                     index]
                                                            //                 .url)!,
                                                            //     //Add videoID.
                                                            //     flags:
                                                            //         const YoutubePlayerFlags(
                                                            //       hideControls:
                                                            //           false,
                                                            //       controlsVisibleAtStart:
                                                            //           true,
                                                            //       autoPlay: false,
                                                            //       mute: false,
                                                            //     ),
                                                            //   ),
                                                            //   showVideoProgressIndicator:
                                                            //       true,
                                                            //   progressIndicatorColor:
                                                            //       AppColors
                                                            //           .primary,
                                                            // ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                dharshanModel
                                                                    .liveDharshan[
                                                                        index]
                                                                    .title,
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
                            // SizedBox(
                            //   height: context.height * 0.02,
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.all(12),
                            //   child: Text(
                            //     'Live TV',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //         color: Colors.brown,
                            //         fontSize: 25,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            // dharshanModel.status == Status.loading
                            //     ? SizedBox(
                            //         height: context.height * 0.2,
                            //         child: const Center(
                            //           child: CircularProgressIndicator(),
                            //         ),
                            //       )
                            //     : dharshanModel.status == Status.error
                            //         ? Center(
                            //             child: Text(
                            //             dharshanModel.error.message.toString(),
                            //             textAlign: TextAlign.center,
                            //             style: const TextStyle(fontSize: 18),
                            //           ))
                            //         : dharshanModel.liveTV.isNotEmpty
                            //             ? SizedBox(
                            //                 height: context.height * 0.38,
                            //                 child: ListView.builder(
                            //                   scrollDirection: Axis.horizontal,
                            //                   itemCount:
                            //                       dharshanModel.liveTV.length,
                            //                   shrinkWrap: true,
                            //                   itemBuilder:
                            //                       (BuildContext context,
                            //                           int index) {
                            //                     return Padding(
                            //                       padding:
                            //                           const EdgeInsets.only(
                            //                               left: 8.0,
                            //                               right: 8.0,
                            //                               bottom: 12.0),
                            //                       child: Container(
                            //                         decoration: const BoxDecoration(
                            //                           // border: Border.all(
                            //                           //     color: Colors.brown,
                            //                           //     width: 8.0),
                            //                             borderRadius: BorderRadius.all(Radius.circular(10)),
                            //                             color: Colors.white70),
                            //                         child: Padding(
                            //                           padding:
                            //                               const EdgeInsets.all(
                            //                                   8.0),
                            //                           child: Column(
                            //                             children: [
                            //                               YoutubePlayerBuilder(
                            //                                 onExitFullScreen:
                            //                                     () {
                            //                                   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                            //                                   SystemChrome
                            //                                       .setPreferredOrientations([
                            //                                     DeviceOrientation
                            //                                         .portraitUp
                            //                                   ]);
                            //                                 },
                            //                                 player:
                            //                                     YoutubePlayer(
                            //                                   controller:
                            //                                       YoutubePlayerController(
                            //                                     initialVideoId: YoutubePlayer.convertUrlToId(
                            //                                         dharshanModel
                            //                                             .liveTV[
                            //                                                 index]
                            //                                             .url)!,
                            //                                     //Add videoID.
                            //                                     flags:
                            //                                         const YoutubePlayerFlags(
                            //                                       hideControls:
                            //                                           false,
                            //                                       isLive: true,
                            //                                       controlsVisibleAtStart:
                            //                                           true,
                            //                                       autoPlay:
                            //                                           false,
                            //                                       mute: false,
                            //                                     ),
                            //                                   ),
                            //                                   showVideoProgressIndicator:
                            //                                       true,
                            //                                   progressIndicatorColor:
                            //                                       AppColors
                            //                                           .primary,
                            //                                 ),
                            //                                 builder: (context,
                            //                                     player) {
                            //                                   return SizedBox(
                            //                                     child: player,
                            //                                   );
                            //                                 },
                            //                               ),
                            //                               Padding(
                            //                                 padding:
                            //                                     const EdgeInsets
                            //                                         .all(8.0),
                            //                                 child: Text(
                            //                                   dharshanModel
                            //                                       .liveTV[index]
                            //                                       .title,
                            //                                   maxLines: 2,
                            //                                   overflow:
                            //                                       TextOverflow
                            //                                           .ellipsis,
                            //                                   style: const TextStyle(
                            //                                       color: Colors.black,
                            //                                       fontSize: 14,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold),
                            //                                 ),
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     );
                            //                   },
                            //                 ),
                            //               )
                            //             : SizedBox(
                            //                 height: context.height * 0.2,
                            //                 child: const Center(
                            //                   child: Text('No Record Found'),
                            //                 ),
                            //               ),
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
