import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/AppAssets.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Lottie.asset(
            AppAssets.diyaStick,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
