import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_indicators.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_snackbar.dart';
import '../../utils/components/custom_textfield.dart';
import '../../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                height: size.height * 0.1,
              ),
              const Text(
                "Create an account!",
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
                controller: usernameController,
                text: "Enter username",
                icon: Icons.email,
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
              CustomTextfield(
                controller: confirmPasswordController,
                text: "Confirm password",
                icon: Icons.email,
                isPassword: true,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomButton(
                callback: () async {
                  if (usernameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    AppSnacbars.snackbar(
                      "Please fill all the required fields.",
                    );
                    return;
                  }

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    AppSnacbars.snackbar(
                      "Password and confirm password should match.",
                    );
                    return;
                  }

                  // make usermodel
                  UserModel userModel = UserModel(
                    name: usernameController.text.trim(),
                    timestamp: DateTime.now(),
                    email: emailController.text.trim(),
                  );

                  AppIndicators.circularIndicator;

                  await authViewModel.registerUser(
                    userModel: userModel,
                    password: passwordController.text,
                  );
                },
                text: "SIGN UP",
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
                    "Already have an account?",
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
                      locator<NavService>().nav.pushNamed(RoutesNames.login);
                    },
                    child: const Text(
                      "SIGN IN",
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
