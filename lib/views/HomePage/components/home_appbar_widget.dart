import 'package:provider/provider.dart';

import '../../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../../viewModels/main_view_model.dart';
import '../../../widgets/logo_widget.dart';
import '../../Login/login_page_widget.dart';

class HomePageAppBarWidget extends StatelessWidget {
  const HomePageAppBarWidget({required this.scaffoldKey,required this.location,required this.logoutPressed,required this.languageButtonPressed,Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String location;
  final VoidCallback logoutPressed;
  final VoidCallback languageButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () =>  scaffoldKey.currentState!.openDrawer(),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 12.0),
                    child: Icon(Icons.menu),
                  ),
                ),
                const LogoWidget(),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('My Location', style: TextStyle(color: Colors.black),),
                    SizedBox(width: context.width * 0.18,child: Text(location, maxLines: 1, overflow: TextOverflow.ellipsis,style: const TextStyle(color: Colors.black),))
                  ],
                ),
              ),
              InkWell(
                onTap: () => languageButtonPressed,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                      'images/language_b.png',
                    ),
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                    Provider.of<MainViewModel>(context,listen: false).logout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPageWidget()),
                            (Route<dynamic> route) => false);
                }, icon: const Icon(Icons.power_settings_new)),
              )
            ],
          )
        ],
      ),
    );
  }
}
