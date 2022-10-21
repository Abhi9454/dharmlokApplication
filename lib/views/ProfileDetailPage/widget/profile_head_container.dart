import '../../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../../constants/AppAssets.dart';

class ProfileHeadWidget extends StatelessWidget {
  const ProfileHeadWidget({required this.profileImage,Key? key}) : super(key: key);


  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.28,
      child: Stack(
        children: [
          Image.asset('images/dashboard.jpeg',
              width: context.width,
              fit: BoxFit.cover,
              height: context.height * 0.25),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                radius: 40, // Image radius
                backgroundImage: NetworkImage(
                    'https://www.dharmlok.com/view/$profileImage'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}