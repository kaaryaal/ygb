class AppException implements Exception {
  final String _message;

  AppException(this._message);

  @override
  String toString() {
    return _message;
  }
}

class NoConnectionException extends AppException {
  NoConnectionException({required String message}) : super(message);
}

class FireException extends AppException {
  FireException({required String message}) : super(message);
}

class FireAuthException extends AppException {
  FireAuthException({required String message}) : super(message);
}

class GenenralException extends AppException {
  GenenralException({required String message}) : super(message);
}
