import 'package:dharmlok/extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../../constants/AppColors.dart';

class ProfileNameContainer extends StatelessWidget {
  const ProfileNameContainer({required this.name, required this.category, required this.onPressed,Key? key}) : super(key: key);

  final String name;
  final String category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.8,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                category,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
          IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.bookmark_add_outlined))
        ],
      ),
    );
  }
}
