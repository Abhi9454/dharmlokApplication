import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dharmlok/models/audio_track_model.dart';

import '../../constants/AppColors.dart';
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

  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  late Source audioSource;
  Duration duration = const Duration(seconds: 0);
  Duration currentPosition = const Duration(seconds: 0);
  int maxDuration = 100;
  int currentPos = 0;
  String currentPostLabel = "00:00";
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxDuration = d.inMilliseconds;
        setState(() {});
      });

      player.onPositionChanged.listen((Duration p) {
        currentPos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentPos).inHours;
        int sminutes = Duration(milliseconds: currentPos).inMinutes;
        int sseconds = Duration(milliseconds: currentPos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentPostLabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
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
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child:
                        widget.playList.isNotEmpty
                            ? GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget.playList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.1),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, bottom: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.brown, width: 8.0),
                                          color: AppColors.onPrimary),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              'https://www.dharmlok.com/view/${widget.playList[index].bannerImageUrl}',
                                              fit: BoxFit.cover,
                                              height: context.height * 0.2,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.playList[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'By: ${widget.playList[index].description}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                // audioSource = UrlSource(
                                                //     'https://www.dharmlok.com/view/${widget.playList[index].audioUrl}');
                                                // //print('https://www.dharmlok.com/view/${widget.playList[index].audioUrl}');
                                                // player.play(audioSource);
                                                assetsAudioPlayer.open(
                                                  Audio.network('https://www.dharmlok.com/view/${widget.playList[index].audioUrl}'),
                                                  autoStart: true,
                                                  showNotification: true,
                                                );
                                                assetsAudioPlayer.play();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              child: const Text(
                                                'PLAY',
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
                              )
                            : SizedBox(
                                height: context.height * 0.2,
                                child: const Center(
                                  child: Text('No Record Found'),
                                ),
                              ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: context.width,
                          height: context.height * 0.08,
                          color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: context.width * 0.6,
                                child: Slider(
                                  value: double.parse(currentPos.toString()),
                                  min: 0,
                                  max: double.parse(maxDuration.toString()),
                                  divisions: maxDuration,
                                  label: currentPostLabel,
                                  onChanged: (double value) async {
                                    int seekval = value.round();
                                    player
                                        .seek(Duration(milliseconds: seekval));
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if(isPlaying){
                                    player.pause();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  }
                                  else{
                                    player.play(audioSource);
                                    setState(() {
                                      isPlaying = true;
                                    });
                                  }
                                },
                                icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow),
                              ),
                            ],
                          ),
                        ),
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
