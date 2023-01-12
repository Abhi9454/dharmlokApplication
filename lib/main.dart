import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dharmlok/viewModels/main_view_model.dart';
import 'package:dharmlok/viewModels/manage_profile_view_model.dart';
import 'package:flutter/services.dart';

import 'constants/AppAssets.dart';
import 'viewModels/home_page_view_model.dart';
import 'viewModels/login_view_model.dart';
import 'viewModels/vendor_view_model.dart';
import 'views/Login/login_page_widget.dart';
import 'package:provider/provider.dart';

import 'views/ManageProfilePage/manage_profile_page_widget.dart';

import 'constants/AppColors.dart';
import 'helpers/read_user_data.dart';
import 'views/HomePage/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider<MainViewModel>(
      create: (_) => MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (_, mainModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) => LoginPageViewModel()),
                ChangeNotifierProvider(create: (context) => VendorViewModel()),
              ],
              child: const NavigationTab(),
            ),
          );
        },
      ),
    );
  }
}

class NavigationTab extends StatefulWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  _NavigationTabState createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  final UserDetails _userDetails = UserDetails();
  int _currentIndex = 0;
  final templeBellAsset = AssetsAudioPlayer();
  final List<Widget> _children = [
    ChangeNotifierProvider<HomePageViewModel>(
      create: (_) => HomePageViewModel(),
      child: HomePageWidget(),
    ),
    // const MyOrdersPageWidget(),
    // const NearByEventsPageWidget(),
    ChangeNotifierProvider<ManageProfileViewModel>(
      create: (_) => ManageProfileViewModel(),
      child: ManageProfilePageWidget(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    Provider.of<MainViewModel>(context,listen: false).fetchUserLocation();
    templeBellAsset.open(
      Audio(AppAssets.templeBell),
    );
    templeBellAsset.play();
  }


  @override
  dispose(){
    templeBellAsset.dispose();
    super.dispose();
  }

  checkLoginStatus() async {
    String token = await _userDetails.getToken();
    if (token.isEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPageWidget()),
          (Route<dynamic> route) => false);
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        // new
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.onPrimary,
        unselectedFontSize: 13,
        selectedFontSize: 13,
        iconSize: 20,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.homeImage),
              ),
              label: 'Home'),
          // BottomNavigationBarItem(
          //     icon: ImageIcon(
          //       AssetImage(AppAssets.eventImage),
          //     ),
          //     label: 'Events Near Me'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.profileImage),
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
