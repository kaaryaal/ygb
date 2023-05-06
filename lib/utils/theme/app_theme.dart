import 'package:fitness_app_mvvm/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    primaryColor: AppColors.lightBlackColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.whiteColor,
    ),
    // textTheme: TextTheme(
    //   titleLarge: GoogleFonts.openSans(
    //     color: AppColors.whiteColor,
    //     fontSize: 25,
    //   ),
    //   titleMedium: GoogleFonts.openSans(
    //     color: AppColors.whiteColor,
    //     fontSize: 22,
    //   ),
    //   titleSmall: GoogleFonts.openSans(
    //     color: AppColors.whiteColor,
    //     fontSize: 20,
    //   ),
    //   bodyLarge: GoogleFonts.openSans(
    //     fontSize: 18,
    //   ),
    //   bodyMedium: GoogleFonts.openSans(
    //     fontSize: 16,
    //   ),
    //   bodySmall: GoogleFonts.openSans(
    //     fontSize: 14,
    //   ),
    // ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.whiteColor,
      contentTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.lightBlackColor,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.whiteColor),
  );
}
