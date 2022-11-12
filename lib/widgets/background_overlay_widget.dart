import '../extensions/device_size.dart';
import 'package:flutter/material.dart';

class BackgroundOverlayWidget extends StatelessWidget {
  const BackgroundOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      color: Colors.blue.withOpacity(0.1),
    );
  }
}
