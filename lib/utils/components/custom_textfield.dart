import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  final TextInputType inputType;
  final IconData icon;
  const CustomTextfield({
    Key? key,
    required this.controller,
    required this.text,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool obsecureText;
  @override
  void initState() {
    obsecureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecureText,
      controller: widget.controller,
      style: const TextStyle(
        color: AppColors.whiteColor,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor.withOpacity(.2),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        prefixIcon: Icon(
          widget.icon,
          color: AppColors.whiteColor,
        ),
        hintText: widget.text,
        hintStyle: const TextStyle(
          color: AppColors.whiteColor,
        ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
                child: Icon(
                  obsecureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
        suffixIconColor: Colors.grey,
        suffixStyle: const TextStyle(
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
