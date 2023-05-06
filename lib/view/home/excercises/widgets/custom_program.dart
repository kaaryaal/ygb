import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/view_model/program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/program_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../utils/components/custom_blur_widget.dart';

class CustomProgram extends StatefulWidget {
  const CustomProgram({
    Key? key,
    required this.program,
  }) : super(key: key);

  final Program program;

  @override
  State<CustomProgram> createState() => _CustomProgramState();
}

class _CustomProgramState extends State<CustomProgram> {
  late ProgramViewModel programViewModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    programViewModel = Provider.of<ProgramViewModel>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: InkWell(
        onTap: () {
          programViewModel.setSelectedProgram(widget.program);
          locator<NavService>().nav.pushNamed(RoutesNames.excerciseDaysScreen);
        },
        child: Container(
          height: size.height * 0.23,
          width: size.width * 0.9,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.program.image!),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              width: 1.0,
              color: AppColors.whiteColor,
            ),
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBlurWidget(text: widget.program.name!),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomBlurWidget(text: widget.program.programLevel!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
