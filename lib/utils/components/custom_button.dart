import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final double height;
  final double width;
  final double radius;
  const CustomButton({
    Key? key,
    required this.callback,
    required this.text,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            // side: const BorderSide(color: Colors.red),
          ),
        ),
        elevation: const MaterialStatePropertyAll<double>(5.0),
        backgroundColor: const MaterialStatePropertyAll<Color>(
          AppColors.blueColor,
        ),
        fixedSize: MaterialStatePropertyAll<Size>(Size(width, height)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
