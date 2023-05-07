import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_indicators.dart';
import '../../../utils/locator/locator.dart';
import '../../../utils/nav_service.dart';
import '../../../view_model/auth_view_model.dart';
import '../../../view_model/subscription_view_model.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late AuthViewModel authViewModel;
  late SubscriptionViewModel subscriptionViewModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authViewModel = Provider.of<AuthViewModel>(context);
    subscriptionViewModel = Provider.of<SubscriptionViewModel>(context);

    getSubscriptionText() {
      if (authViewModel.isSubscribed == null) {
        return "Buy subscription";
      } else if (authViewModel.isSubscribed == true) {
        return "Subscribed";
      } else {
        return "Renew subcription";
      }
    }

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
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 0.04,
                right: size.width * 0.04,
              ),
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(size.height * 0.02),
              ),
              child: InkWell(
                onTap: () async {
                  if (authViewModel.isSubscribed == true) {
                    return;
                  }
                  showDialog(
                    context: locator<NavService>().nav.context,
                    builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );
                  await subscriptionViewModel.buySubscription();
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.subscriptions,
                      color: AppColors.blackColor,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      getSubscriptionText(),
                      style: const TextStyle(
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
            height: size.height * 0.02,
          ),
          if (authViewModel.isSubscribed != null ||
              authViewModel.isSubscribed == false)
            Text(
              "Expires on ${DateFormat("dd MMM yy hh:mm").format(authViewModel.user.data!.subscriptionData!)}",
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
}
