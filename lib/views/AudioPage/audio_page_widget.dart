import 'package:dharmlok/models/audio_track_model.dart';

import '../../constants/AppColors.dart';
import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../viewModels/audio_list_view_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../AudioTracksPage/audio_tracks_page_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class AudioPageWidget extends StatelessWidget {
  AudioPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _templeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<AudioListViewModel>(context, listen: false).getUserLocation();
    Provider.of<AudioListViewModel>(context, listen: false).getAudioPlayList();
    Provider.of<AudioListViewModel>(context, listen: false).getAllTracks();
    return Consumer<AudioListViewModel>(
      builder: (con, audioModel, _) {
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
                      location: audioModel.userLocation,
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
                          AssetImage(AppAssets.audioImageWhite),
                          color: Colors.brown,
                          size: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.audioLibrary,
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
                          onTap: () => audioModel.updateCategory('Sanatan'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: audioModel.category == 'Sanatan'
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
                          onTap: () => audioModel.updateCategory('Buddhism'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: audioModel.category == 'Buddhism'
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
                          onTap: () => audioModel.updateCategory('Sikh'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: audioModel.category == 'Sikh'
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
                          onTap: () => audioModel.updateCategory('Jain'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: audioModel.category == 'Jain'
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
                            audioModel.status == Status.loading
                                ? SizedBox(
                                    height: context.height * 0.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : audioModel.status == Status.error
                                    ? Center(
                                        child: Text(
                                        audioModel.error.message.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18),
                                      ))
                                    : audioModel.playList.isNotEmpty
                                        ? SizedBox(
                                            height: context.height * 0.7,
                                            child: GridView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  audioModel.playList.length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            1.3),
                                              ),
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
                                                            'https://www.dharmlok.com/view/${audioModel.playList[index].imageUrl}',
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
                                                              audioModel
                                                                  .playList[
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
                                                              List<AudioTrackModel>
                                                                  playLists =
                                                                  [];
                                                              for (int i = 0;
                                                                  i <
                                                                      audioModel
                                                                          .allTracks
                                                                          .length;
                                                                  i++) {
                                                                if (audioModel
                                                                        .allTracks[
                                                                            i]
                                                                        .playlist ==
                                                                    audioModel
                                                                        .playList[
                                                                            index]
                                                                        .name) {
                                                                  playLists.add(
                                                                      audioModel
                                                                          .allTracks[i]);
                                                                }
                                                              }
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AudioTracksPageWidget(
                                                                    playList:
                                                                        playLists,
                                                                    userLocation:
                                                                        audioModel
                                                                            .userLocation,
                                                                    playListName: audioModel
                                                                        .playList[
                                                                            index]
                                                                        .name,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                            child: const Text(
                                                              'View Tracks',
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
                                              child: Text('Loading'),
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
