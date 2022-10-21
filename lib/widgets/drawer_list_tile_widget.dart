import 'package:flutter/material.dart';

class DrawerListTileWidget extends StatelessWidget {
  const DrawerListTileWidget({required this.imageName, required this.imageText,Key? key}) : super(key: key);

  final String imageName;
  final String imageText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: AssetImage(
          imageName,
        ),
        width: 20,
        height: 20,
        fit: BoxFit.cover,
      ),
      title: Text(imageText),
    );
  }
}
