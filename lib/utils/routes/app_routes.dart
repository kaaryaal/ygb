import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/utils/routes/undefiend_route.dart';
import 'package:fitness_app_mvvm/view/auth/forgot_view.dart';
import 'package:fitness_app_mvvm/view/auth/login_view.dart';
import 'package:fitness_app_mvvm/view/auth/signup_view.dart';
import 'package:fitness_app_mvvm/view/home/excercises/excercise_details_view.dart';
import 'package:fitness_app_mvvm/view/home/excercises/excercises_days_view.dart';
import 'package:fitness_app_mvvm/view/home/excercises/excercises_view.dart';
import 'package:fitness_app_mvvm/view/home/excercises/play_video_view.dart';
import 'package:fitness_app_mvvm/view/home/home_view.dart';
import 'package:fitness_app_mvvm/view/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );

      case RoutesNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );

      case RoutesNames.register:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
        );

      case RoutesNames.forgot:
        return MaterialPageRoute(
          builder: (context) => const ForgotView(),
        );

      case RoutesNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );

      case RoutesNames.excerciseDaysScreen:
        return MaterialPageRoute(
          builder: (context) => const ExcersicsesDaysView(),
        );

      case RoutesNames.excercisesViewScreen:
        return MaterialPageRoute(
          builder: (context) => const ExcercisesView(),
        );

      case RoutesNames.excercisesDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => const ExcerciseDetailsView(),
        );

      case RoutesNames.playVideoScreen:
        return MaterialPageRoute(
          builder: (context) => const PlayVideoView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings,
        );
    }
  }
}
