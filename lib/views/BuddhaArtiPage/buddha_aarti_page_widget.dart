import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dharmlok/constants/AppAssets.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import '../../viewModels/audio_list_view_model.dart';
import '../AudioPage/audio_page_widget.dart';

class BuddhaAartiPageWidget extends StatefulWidget {
  const BuddhaAartiPageWidget({Key? key}) : super(key: key);

  @override
  State<BuddhaAartiPageWidget> createState() => _BuddhaAartiPageWidgetState();
}

class _BuddhaAartiPageWidgetState extends State<BuddhaAartiPageWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {


  List<String> imageList = [
    AppAssets.buddhaBhagwan,
  ];

  late Path _path;

  bool isFalling = false;
  late SharedPreferences _preferences;
  late AnimationController animationController;

  final AutoScrollController controller =
  AutoScrollController(axis: Axis.horizontal);
  late Animation<double> animation;

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
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation =
    Tween<double>(begin: -100, end: 800).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

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
                  height: context.height * 0.65,
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
                                Audio(AppAssets.buddhaAarti),
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
                        InkWell(
                          onTap: () {
                            if (isFalling) {
                              animationController.reset();
                              isFalling = false;
                            } else {
                              animationController.forward();
                              isFalling = true;
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
                                  image: AssetImage(AppAssets.flowerImage),
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
            isFalling
                ? Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.7, -0.9),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.1, -0.1),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.42, -0.23),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.5, -0.55),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.6, -0.6),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.9, -0.1),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.86, 0.13),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.40, 0.34),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.23, 0.34),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.45, 0.56),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.67, 0.83),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage3,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.6, -0.6),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.6, -0.6),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.32, -0.35),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage1,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0, 0.4),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage3,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.86, 0.13),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.86, 0.13),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.16, -0.13),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.39, -0.29),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.46, -0.55),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.59, -0.67),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.78, -0.73),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.60, -0.87),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.49, -0.74),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.43, -0.54),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.37, -0.47),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.25, -0.51),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.56, 0.29),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.56, 0.47),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.61, 0.74),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.73, 0.33),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.36, 0.93),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.7, 0.4),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.26, -0.63),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.92, -0.43),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(0.49, 0.59),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 50,
                    height: 50,
                  )),
            )
                : const SizedBox(),
            isFalling
                ? Align(
              alignment: const Alignment(-0.90, 0.43),
              child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    AppAssets.flowerImage2,
                    width: 40,
                    height: 40,
                  )),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
