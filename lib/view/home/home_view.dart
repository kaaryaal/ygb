import 'package:fitness_app_mvvm/view/home/widgets/custom_program.dart';
import 'package:fitness_app_mvvm/view_model/program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';
import '../../res/app_colors.dart';
import '../../utils/components/custom_dropdown.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ProgramViewModel programViewModel;

  List<String> dropdownValues = [
    'Beginner',
    'Intermediate',
    'Advance',
  ];

  ValueNotifier<String> selectedValue = ValueNotifier<String>("");

  @override
  void initState() {
    selectedValue.value = dropdownValues[0];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      programViewModel.loadPrograms(level: selectedValue.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    programViewModel = Provider.of<ProgramViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.lightBlackColor,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                header(),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomDropdown(
                  selectedValue: selectedValue,
                  dropdownValues: dropdownValues,
                  onDropdownChanged: (val) {
                    selectedValue.value = val;
                    programViewModel.loadPrograms(level: selectedValue.value);
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  "Programs",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                buildPrograms(),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildPrograms() {
    switch (programViewModel.programs.status) {
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
              if (programViewModel.programs.data!.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "No programs for ${selectedValue.value} level",
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ...programViewModel.programs.data!.map((e) => CustomProgram(
                    program: e,
                  )),
            ],
          ),
        );

      case Status.ERROR:
        return Center(
          child: Text(
              programViewModel.programs.message ?? "Something wen't wrong"),
        );

      default:
        return Container();
    }
  }
}

Row header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () {
          // will open the profile tab
        },
        child: const CircleAvatar(
          backgroundColor: AppColors.whiteColor,
          child: Icon(
            Icons.person,
            color: AppColors.lightBlackColor,
          ),
        ),
      ),
      const Text(
        "Home",
        style: TextStyle(
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
