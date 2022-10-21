import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../../constants/AppAssets.dart';


class KathavachakListContainer extends StatelessWidget {
  const KathavachakListContainer({required this.name, required this.category, required this.imageLink,required this.onPressed,Key? key}) : super(key: key);

  final String name;
  final String imageLink;
  final String category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: context.height * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown),
          color: Colors.brown,
          borderRadius: const BorderRadius.all(
              Radius.circular(
                  5.0) //                 <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const CircleAvatar(
                      radius: 30, // Image radius
                      backgroundImage: AssetImage(
                          AppAssets.profileImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                color: AppColors.secondary,
                                fontSize: 16),
                          ),
                          Text(
                            'Kathavachak/$category',
                            style: const TextStyle(
                                color: AppColors.secondary,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style:
                  ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.red),
                  child: const Text(
                    'View',
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
