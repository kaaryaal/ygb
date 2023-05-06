// import 'package:fitness_app_mvvm/repository/auth/auth_repo.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:get_it/get_it.dart';

// import '../../repository/auth/auth_repo_imp.dart';
//
final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => NavService());
  // locator.registerLazySingleton<AuthRepo>(() => AuthRepoImp());
}
