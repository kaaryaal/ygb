// ignore_for_file: use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_mvvm/repository/auth/auth_repo.dart';
import '../../model/user_model.dart';
import '../../res/app_collections.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getUserData() async {
    try {
      var userResponse = await _firebaseFirestore
          .collection(AppCollections.users)
          .where("uid", isEqualTo: _firebaseAuth.currentUser!.uid)
          .get();
      UserModel userModel;
      userModel = UserModel.fromMap(userResponse.docs[0].data());
      userModel.uid = _firebaseAuth.currentUser!.uid;
      return userModel;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<dynamic> getUser() async {
    // first check if the user exists
    if (_firebaseAuth.currentUser != null) {
      return await getUserData();
    } else {
      return null;
    }
  }

  @override
  Future<dynamic> registerUers({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      var firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );

      userModel.uid = firebaseUser.user!.uid;

      await _firebaseFirestore
          .collection(AppCollections.users)
          .add(userModel.toMap());

      return await getUserData();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getUserData();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<dynamic> forgotUser({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future logout() async {
    await _firebaseAuth.signOut();
  }
}
