// ignore_for_file: use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_mvvm/model/excercise_model.dart';
import 'package:fitness_app_mvvm/repository/excercise/excercise_repo.dart';

import '../../res/app_collections.dart';

class ExcerciseRepoImp implements ExcerciseRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<dynamic> loadExcercises({
    required String programId,
    required int day,
  }) async {
    try {
      var response = await _firebaseFirestore
          .collection(AppCollections.excercises)
          .where("programId", isEqualTo: programId)
          .get();

      return response.docs.map((e) {
        Excercise excercise = Excercise.fromMap(e.data());
        excercise.id = e.id;
        return excercise;
      }).toList();
    } catch (e) {
      throw e;
    }
  }
}
