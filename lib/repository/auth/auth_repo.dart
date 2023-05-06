import 'package:fitness_app_mvvm/model/user_model.dart';

abstract class AuthRepo {
  Future getUser();
  Future registerUers({required UserModel userModel, required String password});
  Future loginUser({required String email, required String password});
  Future forgotUser({required String email});
  Future logout();
}
