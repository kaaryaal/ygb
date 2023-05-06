import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:flutter/material.dart';

import '../locator/locator.dart';

class AppSnacbars {
  static snackbar(String message) {
    return ScaffoldMessenger.of(locator<NavService>().nav.context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
