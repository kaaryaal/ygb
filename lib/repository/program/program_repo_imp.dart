// ignore_for_file: use_rethrow_when_possible
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app_mvvm/repository/program/program_repo.dart';
import '../../model/program_model.dart';
import '../../res/app_collections.dart';

class ProgramRepoImp implements ProgramRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<dynamic> loadPrograms(String level) async {
    try {
      List<Program> programs = [];

      var response = await _firebaseFirestore
          .collection(AppCollections.programs)
          .where("programLevel", isEqualTo: level)
          .get();
      programs = response.docs.map((e) {
        Program program = Program.fromMap(e.data());
        program.id = e.id;
        return program;
      }).toList();

      return programs;
    } catch (e) {
      throw e;
    }
  }
}
