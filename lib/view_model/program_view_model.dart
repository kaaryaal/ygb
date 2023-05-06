import 'package:fitness_app_mvvm/data/response/firestore_response.dart';
import 'package:fitness_app_mvvm/model/program_model.dart';
import 'package:fitness_app_mvvm/repository/program/program_repo.dart';
import 'package:fitness_app_mvvm/repository/program/program_repo_imp.dart';
import 'package:flutter/material.dart';

class ProgramViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> days = [
    {
      "day": "Monday",
      "id": 1,
    },
    {
      "day": "Tuesday",
      "id": 2,
    },
    {
      "day": "Wednesday",
      "id": 1,
    },
    {
      "day": "Thursday",
      "id": 1,
    },
    {
      "day": "Friday",
      "id": 1,
    },
    {
      "day": "Saturday",
      "id": 1,
    },
  ];

  final ProgramRepo _programRepoImp = ProgramRepoImp();

  FirestoreResponse<List<Program>> _programs = FirestoreResponse.loading();
  Program? _selectedProgram;
  Map<String, dynamic>? _selectedDay;

  FirestoreResponse<List<Program>> get programs => _programs;
  Program? get selectedProgram => _selectedProgram;
  Map<String, dynamic>? get selectedDay => _selectedDay;

  setSelectedDay(Map<String, dynamic> map) {
    _selectedDay = map;
    notifyListeners();
  }

  setSelectedProgram(Program program) {
    _selectedProgram = program;
    notifyListeners();
  }

  setPrograms(FirestoreResponse<List<Program>> response) {
    _programs = response;
    notifyListeners();
  }

  loadPrograms({required String level}) async {
    try {
      setPrograms(FirestoreResponse.loading());
      var response = await _programRepoImp.loadPrograms(level);
      setPrograms(FirestoreResponse.completed(response));
    } catch (e) {
      setPrograms(FirestoreResponse.error(e.toString()));
    }
  }
}
