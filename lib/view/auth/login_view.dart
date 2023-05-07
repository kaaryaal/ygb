import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/app_colors.dart';
import '../../res/app_indicators.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_snackbar.dart';
import '../../utils/components/custom_textfield.dart';
import '../../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              const Center(
                child: Text(
                  "Logo here",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              const Text(
                "Login to Your Account!",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "You are almost there to feel great",
                style: TextStyle(
                  color: AppColors.whiteColor.withOpacity(.6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextfield(
                controller: emailController,
                text: "Enter Email",
                icon: Icons.email,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextfield(
                controller: passwordController,
                text: "Enter Password",
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      locator<NavService>().nav.pushNamed(RoutesNames.forgot);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.whiteColor.withOpacity(.6),
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomButton(
                callback: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    AppSnacbars.snackbar(
                      "Please fill both the fields.",
                    );
                    return;
                  }

                  showDialog(
                    context: locator<NavService>().nav.context,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );

                  await authViewModel.loginUser(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                },
                text: "SIGN IN",
                height: size.height * 0.06,
                width: size.width * 0.9,
                radius: size.height * 0.015,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create New account?",
                    style: TextStyle(
                      color: AppColors.whiteColor.withOpacity(.6),
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      locator<NavService>().nav.pushNamed(RoutesNames.register);
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: AppColors.blueColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
