import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../../constants/AppStrings.dart';

class DharmguruListContainer extends StatelessWidget {
  const DharmguruListContainer({required this.profileImage,required this.name,required this.category,required this.onPressed,Key? key}) : super(key: key);

  final String profileImage;
  final String name;
  final String category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: context.height * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          color: Colors.white70,
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
                    CircleAvatar(
                      radius: 30, // Image radius
                      backgroundImage: NetworkImage(
                          '${AppStrings.imageUrl}$profileImage'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width : context.width * 0.45,
                            child: Center(
                              child: Text(
                                name,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0XFF604e36),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Text(
                            'Dharmguru/$category',
                            style: const TextStyle(
                                color: Color(0XFF604e36),
                                fontWeight: FontWeight.bold,
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
                      Color(0XFFA60606)),
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
