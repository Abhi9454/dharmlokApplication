import 'package:dharmlok/constants/AppAssets.dart';
import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';


class AartiPageWidget extends StatefulWidget {
  const AartiPageWidget({Key? key}) : super(key: key);

  @override
  State<AartiPageWidget> createState() => _AartiPageWidgetState();
}

class _AartiPageWidgetState extends State<AartiPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF604e36),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(AppAssets.templeFrame, fit: BoxFit.fill,height: context.height,),
          ],
        ),
      ),
    );
  }
}
