import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app_mvvm/data/response/status.dart';
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

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: buildUi(),
    );
  }

  buildUi() {
    switch (authViewModel.user.status) {
      case Status.LOADING:
        return const Center(
          child: Text(
            "Fitness app",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 25.0,
            ),
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
