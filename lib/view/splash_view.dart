import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app_mvvm/data/response/status.dart';
import 'package:fitness_app_mvvm/res/app_images.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../res/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late AuthViewModel authViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authViewModel.initUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of<AuthViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: buildUi(size),
    );
  }

  buildUi(Size size) {
    switch (authViewModel.user.status) {
      case Status.LOADING:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                width: size.width * 0.5,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        );

      case Status.COMPLETED:
        return;

      case Status.ERROR:
        return Center(
          child: AutoSizeText(
            authViewModel.user.message ?? "Something wen't wrong",
            style: const TextStyle(color: AppColors.whiteColor),
          ),
        );

      default:
        return Container();
    }
  }
}
