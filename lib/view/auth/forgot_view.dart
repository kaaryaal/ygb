import 'package:fitness_app_mvvm/res/app_indicators.dart';
import 'package:fitness_app_mvvm/utils/components/custom_snackbar.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_textfield.dart';
import '../../utils/locator/locator.dart';
import '../../utils/nav_service.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  late TextEditingController emailController;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              Image.asset(
                AppImages.logo,
                width: size.width * 0.5,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              const Text(
                "Forgot password?",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                "Enter your registered email!",
                style: TextStyle(
                  color: AppColors.whiteColor.withOpacity(.6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              CustomTextfield(
                controller: emailController,
                text: "Enter Email",
                icon: Icons.email,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomButton(
                callback: () async {
                  if (emailController.text.isEmpty) {
                    AppSnacbars.snackbar("Please enter your email.");
                    return;
                  }

                  showDialog(
                    context: locator<NavService>().nav.context,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );

                  await authViewModel.forgotUser(
                      email: emailController.text.trim());
                },
                text: "SUBMIT",
                height: size.height * 0.06,
                width: size.width * 0.9,
                radius: size.height * 0.015,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
