import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:fitness_app_mvvm/utils/routes/app_routes.dart';
import 'package:fitness_app_mvvm/utils/routes/routes_names.dart';
import 'package:fitness_app_mvvm/utils/theme/app_theme.dart';
import 'package:fitness_app_mvvm/view_model/auth_view_model.dart';
import 'package:fitness_app_mvvm/view_model/excercise_view_model.dart';
import 'package:fitness_app_mvvm/view_model/program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  // init firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // locator registery
  setupLocator();
  // run fitness application
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProgramViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExcerciseViewModel(),
        ),
      ],
      child: const FitnessApp(),
    ),
  );
}

class FitnessApp extends StatefulWidget {
  const FitnessApp({super.key});

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  final NavService navigationService = locator<NavService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationService.rootNavKey,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RoutesNames.splash,
      theme: AppTheme.theme,
    );
  }
}
