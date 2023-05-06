abstract class ExcerciseRepo {
  Future<dynamic> loadExcercises({
    required String programId,
    required int day,
  });
}
