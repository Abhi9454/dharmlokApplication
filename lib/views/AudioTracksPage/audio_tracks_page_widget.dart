
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dharmlok/models/audio_track_model.dart';
import 'package:dharmlok/views/AudioTracksPage/progress_manager.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppStrings.dart';
import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class AudioTracksPageWidget extends StatefulWidget {
  AudioTracksPageWidget(
      {required this.playList,
      required this.userLocation,
      required this.playListName,
      Key? key})
      : super(key: key);

  final List<AudioTrackModel> playList;
  final String userLocation;
  final String playListName;

  @override
  State<AudioTracksPageWidget> createState() => _AudioTracksPageWidgetState();
}

class _AudioTracksPageWidgetState extends State<AudioTracksPageWidget>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _templeKey = GlobalKey();

  late PageManager _pageManager;

  String formatTime(Duration duration){
    String twoDigits(int n ) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);

    return [
      if(duration.inHours > 0) hours,
      minutes,seconds
    ].join(":");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        icon: const Icon(Icons.arrow_back_ios)),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                        width: context.width * 0.7,
                        child: Text(
                          widget.playListName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 25,
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: widget.playList.isNotEmpty
                        ? GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.playList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.1),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 12.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      // border: Border.all(
                                      //     color: Colors.brown, width: 8.0),
                                      color: Colors.white70),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          '${AppStrings.imageUrl}${widget.playList[index].bannerImageUrl}',
                                          fit: BoxFit.cover,
                                          height: context.height * 0.2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.playList[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'By: ${widget.playList[index].description}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            _pageManager = PageManager('${AppStrings.imageUrl}${widget.playList[index].audioUrl}');
                                            //setAudio('https://www.dharmlok.com/view/${widget.playList[index].audioUrl}');
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                backgroundColor: Colors.white,
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (builder) {
                                                  return Container(
                                                    height:
                                                        context.height * 0.65,
                                                    color: Colors.transparent,
                                                    //could change this to Color(0xFF737373),
                                                    //so you don't have to change MaterialApp canvasColor
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0))),
                                                      child: Center(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: context
                                                                      .height *
                                                                  0.03,
                                                            ),
                                                            Image.network(
                                                              '${AppStrings.imageUrl}${widget.playList[index].bannerImageUrl}',
                                                              fit: BoxFit.cover,
                                                              height: context
                                                                      .height *
                                                                  0.3,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                widget
                                                                    .playList[
                                                                        index]
                                                                    .title,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'By: ${widget.playList[index].description}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .primary,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            ValueListenableBuilder<ProgressBarState>(
                                                              valueListenable: _pageManager.progressNotifier,
                                                              builder: (_, value, __) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                                                                  child: ProgressBar(
                                                                    progress: value.current,
                                                                    buffered: value.buffered,
                                                                    total: value.total,
                                                                    onSeek: _pageManager.seek,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            ValueListenableBuilder<ButtonState>(
                                                              valueListenable: _pageManager.buttonNotifier,
                                                              builder: (_, value, __) {
                                                                switch (value) {
                                                                  case ButtonState.loading:
                                                                    return Container(
                                                                      margin: const EdgeInsets.all(8.0),
                                                                      width: 32.0,
                                                                      height: 32.0,
                                                                      child: const CircularProgressIndicator(),
                                                                    );
                                                                  case ButtonState.paused:
                                                                    return IconButton(
                                                                      icon: const Icon(Icons.play_arrow),
                                                                      iconSize: 32.0,
                                                                      onPressed: _pageManager.play,
                                                                    );
                                                                  case ButtonState.playing:
                                                                    return IconButton(
                                                                      icon: const Icon(Icons.pause),
                                                                      iconSize: 32.0,
                                                                      onPressed: _pageManager.pause,
                                                                    );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).whenComplete((){
                                                  _pageManager.dispose();
                                              print('Dispose is called');
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text(
                                            'PLAY',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            height: context.height * 0.2,
                            child: const Center(
                              child: Text('No Record Found'),
                            ),
                          ),
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
