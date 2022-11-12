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
        height: context.height * 0.13,
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  imageName,
                ),
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  imageText,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Color(0XFF604E36),
                      fontSize: 12,
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
