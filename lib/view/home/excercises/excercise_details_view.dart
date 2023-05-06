import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/view_model/excercise_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/app_colors.dart';

class ExcerciseDetailsView extends StatefulWidget {
  const ExcerciseDetailsView({super.key});

  @override
  State<ExcerciseDetailsView> createState() => _ExcerciseDetailsViewState();
}

class _ExcerciseDetailsViewState extends State<ExcerciseDetailsView> {
  final NavService navService = locator<NavService>();
  late ExcerciseViewModel excerciseViewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    excerciseViewModel = Provider.of<ExcerciseViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
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
                    excerciseViewModel.selectedExcercise!.excerciseName!,
                    overflow: TextOverflow.ellipsis,
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
                height: size.height * 0.04,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            excerciseViewModel.selectedExcercise!.image!),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      excerciseViewModel.selectedExcercise!.excerciseName!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    "${excerciseViewModel.selectedExcercise!.minutes!} min",
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Instructions:",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  excerciseViewModel.selectedExcercise!.instructions!,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        onPressed: () {
          locator<NavService>().nav.pushNamed(RoutesNames.playVideoScreen);
        },
        child: const Icon(
          Icons.play_arrow,
          color: AppColors.blueColor,
          size: 30,
        ),
      ),
    );
  }
}
