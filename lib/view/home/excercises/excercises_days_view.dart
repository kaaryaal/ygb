import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/view_model/program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';

class ExcersicsesDaysView extends StatefulWidget {
  const ExcersicsesDaysView({super.key});

  @override
  State<ExcersicsesDaysView> createState() => _ExcersicsesDaysViewState();
}

class _ExcersicsesDaysViewState extends State<ExcersicsesDaysView> {
  late ProgramViewModel programViewModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    programViewModel = Provider.of<ProgramViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              header(),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "Select Day",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ...buildDays(size),
            ],
          ),
        ),
      ),
    );
  }

  buildDays(Size size) {
    return programViewModel.days
        .map((String e) => InkWell(
              onTap: () {
                programViewModel.setSelectedDay(e);
                locator<NavService>()
                    .nav
                    .pushNamed(RoutesNames.excercisesViewScreen);
              },
              child: Container(
                height: size.height * 0.09,
                width: size.width * 0.9,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: AppColors.whiteColor, width: 1),
                ),
                child: Center(
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            locator<NavService>().nav.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
          ),
        ),
        Text(
          programViewModel.selectedProgram!.name!,
          style: const TextStyle(
            fontSize: 18.0,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }
}
