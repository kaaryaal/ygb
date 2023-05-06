import 'dart:developer';

import 'package:fitness_app_mvvm/data/response/firestore_response.dart';
import 'package:fitness_app_mvvm/repository/auth/auth_repo.dart';
import 'package:fitness_app_mvvm/repository/auth/auth_repo_imp.dart';
import 'package:fitness_app_mvvm/utils/components/custom_snackbar.dart';
import 'package:fitness_app_mvvm/utils/locator/locator.dart';
import 'package:fitness_app_mvvm/utils/nav_service.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../utils/routes/routes_names.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepo _authReopImp = AuthRepoImp();
  final NavService navService = locator<NavService>();

  FirestoreResponse<UserModel> _user = FirestoreResponse.loading();

  FirestoreResponse<UserModel> get user => _user;

  initUser() async {
    try {
      var response = await _authReopImp.getUser();
      setUser(FirestoreResponse.completed(response));
      if (_user.data == null) {
        locator<NavService>().nav.pushNamedAndRemoveUntil(
              RoutesNames.login,
              (Route<dynamic> route) => false,
            );
      } else {
        locator<NavService>().nav.pushNamedAndRemoveUntil(
              RoutesNames.home,
              (Route<dynamic> route) => false,
            );
      }
    } catch (e) {
      setUser(FirestoreResponse.error(e.toString()));
    }
  }

  setUser(FirestoreResponse<UserModel> response) {
    _user = response;
    notifyListeners();
  }

  loginUser({required String email, required String password}) async {
    try {
      var response =
          await _authReopImp.loginUser(email: email, password: password);
      setUser(FirestoreResponse.completed(response));
      locator<NavService>().nav.pushNamedAndRemoveUntil(
            RoutesNames.home,
            (Route<dynamic> route) => false,
          );
    } catch (e) {
      setUser(FirestoreResponse.error(e.toString()));
    }
  }

  registerUser({required UserModel userModel, required String password}) async {
    var response = await _authReopImp.registerUers(
      userModel: userModel,
      password: password,
    );

    try {
      setUser(FirestoreResponse.completed(response));
    } catch (e) {
      setUser(FirestoreResponse.error(e.toString()));
    }
  }

  forgotUser({required String email}) async {
    try {
      await _authReopImp.forgotUser(email: email);
      navService.nav
          .pushNamedAndRemoveUntil(RoutesNames.login, (route) => false);
      AppSnacbars.snackbar("Please check your email!");
    } catch (e) {
      navService.nav.pop();
      AppSnacbars.snackbar(e.toString());
    }
  }

  logout() async {
    await _authReopImp.logout();
    navService.nav.pushNamedAndRemoveUntil(RoutesNames.login, (route) => false);
    // navigate to login screen
  }
}
