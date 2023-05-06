import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomBlurWidget extends StatelessWidget {
  const CustomBlurWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withOpacity(.8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
