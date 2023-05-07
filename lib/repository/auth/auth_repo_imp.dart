// ignore_for_file: use_rethrow_when_possible
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_mvvm/data/app_exceptions.dart';
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
      if (userResponse.docs.isEmpty) {
        await logout();
        return;
      }
      UserModel userModel;
      userModel = UserModel.fromMap(userResponse.docs[0].data());
      userModel.uid = _firebaseAuth.currentUser!.uid;
      return userModel;
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } on FirebaseAuthException catch (e) {
      throw checkError(e);
    } catch (e) {
      throw GenenralException(message: e.toString());
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
  Future updateUser({required UserModel userModel}) async {
    try {
      var userDocs = await _firebaseFirestore
          .collection(AppCollections.users)
          .where("uid", isEqualTo: userModel.uid!)
          .get();
      if (userDocs.docs.isNotEmpty) {
        await _firebaseFirestore
            .collection(AppCollections.users)
            .doc(userDocs.docs[0].id)
            .update(userModel.toMap());
      }
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } on FirebaseAuthException catch (e) {
      throw checkError(e);
    } catch (e) {
      log(e.toString());
      throw FireException(message: e.toString());
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
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } on FirebaseAuthException catch (e) {
      throw checkError(e);
    } catch (e) {
      log(e.toString());
      throw FireException(message: e.toString());
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
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } on FirebaseAuthException catch (e) {
      throw checkError(e);
    } catch (e) {
      throw FireException(message: e.toString());
    }
  }

  @override
  Future<dynamic> forgotUser({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } on FirebaseAuthException catch (e) {
      throw checkError(e);
    } catch (e) {
      throw FireException(message: e.toString());
    }
  }

  @override
  Future logout() async {
    await _firebaseAuth.signOut();
  }

  AppException checkError(FirebaseAuthException e) {
    log(e.code);
    if (e.code == "wrong-password") {
      return FireAuthException(message: "Wrong password.");
    } else if (e.code == "invalid-email") {
      return FireAuthException(message: "Invalid email.");
    } else if (e.code == "user-disabled") {
      return FireAuthException(message: "Your account has been disabled.");
    } else if (e.code == "user-not-found") {
      return FireAuthException(message: "User not found with this email.");
    }
    // errors for creating new account
    else if (e.code == "email-already-in-use") {
      return FireAuthException(message: "This email is already in use.");
    } else if (e.code == "weak-password") {
      return FireAuthException(message: "Use a strong password.");
    } else if (e.code == "network-request-failed") {
      return FireAuthException(message: "No internet connection.");
    } else {
      return GenenralException(message: "Somethign wen't wroing");
    }
  }
}
