import 'package:fitness_app_mvvm/data/response/firestore_response.dart';
import 'package:fitness_app_mvvm/model/program_model.dart';
import 'package:fitness_app_mvvm/repository/program/program_repo.dart';
import 'package:fitness_app_mvvm/repository/program/program_repo_imp.dart';
import 'package:flutter/material.dart';

class ProgramViewModel extends ChangeNotifier {
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  final ProgramRepo _programRepoImp = ProgramRepoImp();

  FirestoreResponse<List<Program>> _programs = FirestoreResponse.loading();
  Program? _selectedProgram;
  String? _selectedDay;

  FirestoreResponse<List<Program>> get programs => _programs;
  Program? get selectedProgram => _selectedProgram;
  String? get selectedDay => _selectedDay;

  setSelectedDay(String day) {
    _selectedDay = day;
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
