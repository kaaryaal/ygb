import 'package:flutter/material.dart';

class NavService {
  NavService();

  GlobalKey<NavigatorState> rootNavKey = GlobalKey();

  NavigatorState get nav => rootNavKey.currentState!;
}
