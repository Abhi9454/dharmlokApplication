import 'dart:convert';
import 'package:dharmlok/viewModels/profile_detail_view_model.dart';
import 'package:dharmlok/views/ProfileDetailPage/widget/profile_head_container.dart';
import 'package:dharmlok/views/ProfileDetailPage/widget/profile_name_container.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppColors.dart';
import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../../widgets/drawer_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class ProfileDetailPageWidget extends StatelessWidget {
  ProfileDetailPageWidget(
      {required this.id,
      required this.name,
      required this.category,
      required this.profileImageUrl,
        required this.coverImageUrl,
      required this.userType,
      Key? key})
      : super(key: key);

  final String name;
  final String category;
  final String id;
  final String profileImageUrl;
  final String coverImageUrl;
  final String userType;

  String updatedBiography = '';


  final GlobalKey<ScaffoldState> _profileDetailPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileDetailViewModel>(context, listen: false)
        .getUserLocation();
    Provider.of<ProfileDetailViewModel>(context, listen: false)
        .getProfileDetail(id);
    Provider.of<ProfileDetailViewModel>(context, listen: false)
        .getAllPosts(category);
    return Consumer<ProfileDetailViewModel>(
      builder: (con, profileModel, _) {
        return Scaffold(
          key: _profileDetailPageKey,
          drawer: const DrawerWidget(),
          body: Stack(
            children: [
              const BackgroundImageWidget(),
              const BackgroundOverlayWidget(),
              SafeArea(
                child: Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _profileDetailPageKey,
                      location: profileModel.userLocation,
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
                        const Text(
                          'Profile',
                          style: TextStyle(
                              color: Color(0XFF604E36),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    profileModel.status == Status.loading
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileHeadWidget(
                                    profileImage: profileImageUrl,
                                    coverImageUrl: coverImageUrl,
                                  ),
                                  ProfileNameContainer(
                                      name: name,
                                      category: category,
                                      onPressed: () {}),
                                  SizedBox(
                                    height: context.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            profileModel.setSelectedTab(0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border:
                                            //     Border.all(color: Colors.brown),
                                            color: profileModel.selectedTab == 0
                                                ? Colors.white70
                                                : Colors.white30,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                                ),
                                          ),
                                          width: context.width * 0.22,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('Posts'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          profileModel.setSelectedTab(1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border:
                                            //     Border.all(color: Colors.brown),
                                            color: profileModel.selectedTab == 1
                                                ? Colors.white70
                                                : Colors.white30,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                                ),
                                          ),
                                          width: context.width * 0.22,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'Biography',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            profileModel.setSelectedTab(2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border:
                                            //     Border.all(color: Colors.brown),
                                            color: profileModel.selectedTab == 2
                                                ? Colors.white70
                                                : Colors.white30,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                                ),
                                          ),
                                          width: context.width * 0.22,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('Videos'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () =>
                                            profileModel.setSelectedTab(3),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border:
                                            //     Border.all(color: Colors.brown),
                                            color: profileModel.selectedTab == 3
                                                ? Colors.white70
                                                : Colors.white30,
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    5.0) //                 <--- border radius here
                                                ),
                                          ),
                                          width: context.width * 0.22,
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('Photos'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: context.height * 0.02,
                                  ),
                                  profileModel.selectedTab == 1
                                      ? Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Container(
                                            color: Colors.white70,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                // child: Text(
                                                //   biography,
                                                //   textAlign: TextAlign.justify,
                                                //   style: const TextStyle(
                                                //       color:
                                                //           AppColors.onPrimary,
                                                //       fontSize: 15),
                                                // ),
                                                child: Html(
                                                    data: profileModel.profileDetails.biography!.description,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 0
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            'Posts',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 0
                                      ? profileModel.postList.isEmpty
                                          ? const SizedBox(
                                              height: 100,
                                              child: Center(
                                                  child:
                                                      Text('No Posts Found')))
                                          : ListView.builder(
                                              itemCount: 10,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0,
                                                          right: 12.0,
                                                          bottom: 12.0),
                                                  child: Card(
                                                    elevation: 2,
                                                    color: Colors.brown,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Row(
                                                            children: [
                                                              const CircleAvatar(
                                                                radius: 20,
                                                                // Image radius
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        AppAssets
                                                                            .profileImage),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      profileModel.postList[index].userName,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              AppColors.onPrimary),
                                                                    ),
                                                                    Text(
                                                                      GetTimeAgo.parse(profileModel.postList[index].createdAt),
                                                                      style: const TextStyle(
                                                                          color:
                                                                              AppColors.onPrimary),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Image.asset(
                                                            profileModel.postList[index].imageUrl,
                                                            width:
                                                                context.width,
                                                            fit: BoxFit.cover,
                                                            height:
                                                                context.height *
                                                                    0.25),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: SizedBox(
                                                            height:
                                                                context.height *
                                                                    0.05,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '${profileModel.postList[index].like} Like',
                                                                  style: const TextStyle(
                                                                      color: AppColors
                                                                          .onPrimary),
                                                                ),
                                                                SizedBox(
                                                                  width: context
                                                                          .width *
                                                                      0.05,
                                                                ),
                                                                Text(
                                                                  '${profileModel.postList[index].comment} Comments',
                                                                  style: const TextStyle(
                                                                      color: AppColors
                                                                          .onPrimary),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 2
                                      ? const Padding(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            'Videos',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 2
                                      ? profileModel.videoList.isEmpty
                                          ? const SizedBox(
                                              height: 100,
                                              child: Center(
                                                  child:
                                                      Text('No Videos Found')))
                                          : ListView.builder(
                                              itemCount: 10,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0,
                                                          right: 12.0,
                                                          bottom: 12.0),
                                                  child: Card(
                                                    elevation: 2,
                                                    color: Colors.brown,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Row(
                                                            children: [
                                                              const CircleAvatar(
                                                                radius:
                                                                    20, // Image radius
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        AppAssets
                                                                            .profileImage),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: const [
                                                                    Text(
                                                                      'Goswami Mridul Krishna Ji',
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.onPrimary),
                                                                    ),
                                                                    Text(
                                                                      '1 month Ago',
                                                                      style: TextStyle(
                                                                          color:
                                                                              AppColors.onPrimary),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Image.asset(
                                                            'images/dashboard.jpeg',
                                                            width:
                                                                context.width,
                                                            fit: BoxFit.cover,
                                                            height:
                                                                context.height *
                                                                    0.25),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: SizedBox(
                                                            height:
                                                                context.height *
                                                                    0.05,
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  '2 Likes',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .onPrimary),
                                                                ),
                                                                SizedBox(
                                                                  width: context
                                                                          .width *
                                                                      0.05,
                                                                ),
                                                                const Text(
                                                                  '12 Comments',
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .onPrimary),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 3
                                      ? const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      'Photos',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : const SizedBox(),
                                  profileModel.selectedTab == 3
                                      ? profileModel.photoList.isEmpty
                                      ? const SizedBox(
                                      height: 100,
                                      child: Center(
                                          child:
                                          Text('No Photos Found')))
                                      : ListView.builder(
                                    itemCount: 10,
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context,
                                        int index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            bottom: 12.0),
                                        child: Card(
                                          elevation: 2,
                                          color: Colors.brown,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 15.0),
                                                child: Row(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius:
                                                      20, // Image radius
                                                      backgroundImage:
                                                      AssetImage(
                                                          AppAssets
                                                              .profileImage),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          10.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: const [
                                                          Text(
                                                            'Goswami Mridul Krishna Ji',
                                                            style: TextStyle(
                                                                color:
                                                                AppColors.onPrimary),
                                                          ),
                                                          Text(
                                                            '1 month Ago',
                                                            style: TextStyle(
                                                                color:
                                                                AppColors.onPrimary),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Image.asset(
                                                  'images/dashboard.jpeg',
                                                  width:
                                                  context.width,
                                                  fit: BoxFit.cover,
                                                  height:
                                                  context.height *
                                                      0.25),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 15.0),
                                                child: SizedBox(
                                                  height:
                                                  context.height *
                                                      0.05,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        '2 Likes',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .onPrimary),
                                                      ),
                                                      SizedBox(
                                                        width: context
                                                            .width *
                                                            0.05,
                                                      ),
                                                      const Text(
                                                        '12 Comments',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .onPrimary),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
