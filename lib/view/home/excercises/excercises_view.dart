import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app_mvvm/utils/components/custom_snackbar.dart';
import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
import 'package:fitness_app_mvvm/view_model/excercise_view_model.dart';
import 'package:fitness_app_mvvm/view_model/program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../model/excercise_model.dart';

import '../../../res/app_colors.dart';

class ExcercisesView extends StatefulWidget {
  const ExcercisesView({super.key});

  @override
  State<ExcercisesView> createState() => _ExcercisesViewState();
}

class _ExcercisesViewState extends State<ExcercisesView> {
  final NavService navService = locator<NavService>();
  late ProgramViewModel programViewModel;
  late ExcerciseViewModel excerciseViewModel;
  late AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      excerciseViewModel.loadExcercises(
        programId: programViewModel.selectedProgram!.id!,
        day: programViewModel.selectedDay!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    programViewModel = Provider.of<ProgramViewModel>(context);
    excerciseViewModel = Provider.of<ExcerciseViewModel>(context);
    authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => navService.nav.pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      programViewModel.selectedProgram!.name!,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                buildExcercises(size),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildExcercises(Size size) {
    switch (excerciseViewModel.excercises.status) {
      case Status.LOADING:
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.whiteColor,
          ),
        );

      case Status.COMPLETED:
        return Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (excerciseViewModel.excercises.data!.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "No excercises for ${programViewModel.selectedDay!}",
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ...excerciseViewModel.excercises.data!
                  .map((e) => excerciseWidget(e, size)),
            ],
          ),
        );

      case Status.ERROR:
        return Center(
          child: Text(
            programViewModel.programs.message ?? "Something wen't wrong",
            style: const TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        );

      default:
        return Container();
    }
  }

  excerciseWidget(Excercise excercise, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          log(authViewModel.isSubscribed.toString());
          if (authViewModel.isSubscribed != true) {
            AppSnacbars.snackbar("Please buy subscription to unlock.");
            return;
          }
          excerciseViewModel.setSelectedExcercise(excercise);
          locator<NavService>()
              .nav
              .pushNamed(RoutesNames.excercisesDetailsScreen);
        },
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          // shadowColor: AppColors.whiteColor.withOpacity(.2),
          elevation: 5.0,
          child: Container(
            width: size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.lightBlackColor,
              border: Border.all(
                color: AppColors.whiteColor.withOpacity(.2),
              ),
            ),
            // padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: SizedBox(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    child: Image.network(
                      excercise.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            excercise.excerciseName!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          const Spacer(),
                          if (excercise.paid!) ...[
                            Icon(
                              authViewModel.isSubscribed == true
                                  ? Icons.lock_open
                                  : Icons.lock,
                              color: authViewModel.isSubscribed == true
                                  ? Colors.green
                                  : Colors.redAccent,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      AutoSizeText(
                        excercise.instructions!,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              excercise.shortDescription!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.whiteColor.withOpacity(.7),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${excercise.minutes!} min",
                            style: TextStyle(
                              color: AppColors.whiteColor.withOpacity(.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
