import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/constants/AppAssets.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:wakelock/wakelock.dart';

import '../../viewModels/audio_list_view_model.dart';
import '../AudioPage/audio_page_widget.dart';
import '../sample_page.dart';

class SikhAartiPageWidget extends StatefulWidget {
  const SikhAartiPageWidget({Key? key}) : super(key: key);

  @override
  State<SikhAartiPageWidget> createState() => _SikhAartiPageWidgetState();
}

class _SikhAartiPageWidgetState extends State<SikhAartiPageWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {


  List<String> imageList = [
    AppAssets.guruNanak,
  ];

  late Path _path;

  bool isFalling = false;
  late SharedPreferences _preferences;

  final AutoScrollController controller =
  AutoScrollController(axis: Axis.horizontal);

  var commentWidgets = <Widget>[];

  final ardaasAsset = AssetsAudioPlayer();

  bool rotateAarti = false;

  bool light = false;

  bool showHint = true;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback(_layout);
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {

    Wakelock.disable();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isPlaying = false;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      ardaasAsset.stop();
      ardaasAsset.dispose();
    } else if (state == AppLifecycleState.paused) {
      ardaasAsset.stop();
      ardaasAsset.dispose();
    }
    else if(state == AppLifecycleState.detached){
      ardaasAsset.stop();
      ardaasAsset.dispose();
    }
  }


  checkDate() async {
    _preferences = await SharedPreferences.getInstance();
    String? date = _preferences.getString('date');
    print('This is date$date');
    DateTime currentDate = DateTime.now();
    if (date != null) {
      print('In null If');
      if (currentDate.day == DateTime.parse(date).day &&
          currentDate.month == DateTime.parse(date).month &&
          currentDate.year == DateTime.parse(date).year) {
        light = true;
        print('date match');
      } else {
        //_preferences.setString('date', currentDate.toString());
        light == false;
        print('date not match');
      }
    } else {
      //_preferences.setString('date', currentDate.toString());
      light == false;
      print('else null');
    }
    setState(() {});
  }

  Future _scrollToIndex(int index) async {
    print('This is called $index');
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  bool bellRinging = false;

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Scaffold(
      backgroundColor: const Color(0XFF2a110c),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              AppAssets.templeFrame,
              fit: BoxFit.fill,
              height: context.height,
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                color: Colors.transparent,
                width: context.width,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: SizedBox(
                  height: context.height * 0.8,
                  child: ListView.builder(
                    itemCount: imageList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return AutoScrollTag(
                          key: ValueKey(index),
                          controller: controller,
                          index: index,
                          child: Image.asset(
                            imageList[index],
                            fit: BoxFit.contain,
                            width: context.width,
                          ));
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: context.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if(isPlaying){
                                isPlaying = false;
                                ardaasAsset.dispose();
                            }
                            else{
                              isPlaying = true;
                              ardaasAsset.open(
                                Audio(AppAssets.ardaas),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: const Color(0XFF2a110c),
                                image: const DecorationImage(
                                  image: AssetImage(AppAssets.aartiImage),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                  color: const Color(0XFF2a110c),
                                  width: 4.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Image.asset(AppAssets.aartiImage, fit: BoxFit.contain, width: 100,height: 100,),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const SamplePage()),
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                    providers: <
                                        ChangeNotifierProvider<
                                            AudioListViewModel>>[
                                      ChangeNotifierProvider<
                                          AudioListViewModel>(
                                          create: (_) =>
                                              AudioListViewModel())
                                    ],
                                    child: AudioPageWidget())));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: const Color(0XFF2a110c),
                            image: const DecorationImage(
                              image: AssetImage(AppAssets.songLibraryImage),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(50.0)),
                            border: Border.all(
                              color: const Color(0XFF2a110c),
                              width: 4.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
