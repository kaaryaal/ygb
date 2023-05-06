import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:flutter/material.dart';

class AppIndicators {
  static final circularIndicator = showDialog(
    context: locator<NavService>().nav.context,
    builder: (_) => const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );
}
