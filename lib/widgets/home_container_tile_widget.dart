import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';

class HomeContainerTileWidget extends StatelessWidget {
  const HomeContainerTileWidget({required this.imageName, required this.imageText, required this.onPressed,Key? key}) : super(key: key);

  final String imageName;
  final String imageText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: context.width * 0.28,
        height: context.height * 0.15,
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  imageName,
                ),
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  imageText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
