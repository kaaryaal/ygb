import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitness_app_mvvm/res/app_indicators.dart';
import 'package:fitness_app_mvvm/view/home/excercises/widgets/custom_program.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
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
  late AuthViewModel authViewModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.lightBlackColor,
      drawer: appDrawer(size),
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
                header(context),
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

  Drawer appDrawer(Size size) {
    return Drawer(
      backgroundColor: AppColors.whiteColor.withOpacity(.9),
      child: Column(
        children: [
          Container(
            height: size.height * 0.35,
            width: size.width,
            decoration: BoxDecoration(
              color: AppColors.lightBlackColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(size.height * 0.03),
                bottomRight: Radius.circular(size.height * 0.03),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.whiteColor,
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.blackColor,
                    size: 80,
                  ),
                ),
                const Spacer(),
                Text(
                  authViewModel.user.data!.name!,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                AutoSizeText(
                  authViewModel.user.data!.email!,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: size.width * 0.04),
              height: size.height * 0.08,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(size.height * 0.02),
              ),
              child: InkWell(
                onTap: () async {
                  AppIndicators.circularIndicator;
                  await authViewModel.logout();
                },
                child: Row(
                  children: const [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.logout,
                      color: AppColors.blueColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
        ],
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

  Row header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
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
}
