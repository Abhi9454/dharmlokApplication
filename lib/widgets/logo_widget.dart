import '../extensions/device_size.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        'images/logo.png',
      ),
      width: context.width * 0.3,
      fit: BoxFit.cover,
    );
  }
}
