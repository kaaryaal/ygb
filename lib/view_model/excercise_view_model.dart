import 'package:fitness_app_mvvm/data/response/firestore_response.dart';
import 'package:fitness_app_mvvm/model/excercise_model.dart';
import 'package:fitness_app_mvvm/repository/excercise/excercise_repo.dart';
import 'package:fitness_app_mvvm/repository/excercise/excercise_repo_imp.dart';
import 'package:flutter/material.dart';

class ExcerciseViewModel extends ChangeNotifier {
  final ExcerciseRepo _excerciseRepoImp = ExcerciseRepoImp();
  FirestoreResponse<List<Excercise>> _excercises = FirestoreResponse.loading();
  Excercise? _selectedExcercise;

  FirestoreResponse<List<Excercise>> get excercises => _excercises;
  Excercise? get selectedExcercise => _selectedExcercise;

  setSelectedExcercise(Excercise excercise) {
    _selectedExcercise = excercise;
    notifyListeners();
  }

  setExcercises(FirestoreResponse<List<Excercise>> response) {
    _excercises = response;
    notifyListeners();
  }

  loadExcercises({required String programId, required String day}) async {
    try {
      setExcercises(FirestoreResponse.loading());
      var response = await _excerciseRepoImp.loadExcercises(
        programId: programId,
        day: day,
      );
      setExcercises(FirestoreResponse.completed(response));
    } catch (e) {
      setExcercises(FirestoreResponse.error(e.toString()));
    }
  }
}
