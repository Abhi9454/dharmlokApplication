import '../extensions/device_size.dart';
import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(
        'images/background.png',
      ),
      width: context.width,
      height: context.height,
      fit: BoxFit.cover,
    );
  }
}
