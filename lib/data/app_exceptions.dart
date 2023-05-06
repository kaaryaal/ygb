class AppExceptions implements Exception {
  final String _message;

  AppExceptions(this._message);

  @override
  String toString() {
    return _message;
  }
}

class NoConnectionException extends AppExceptions {
  NoConnectionException({required String message}) : super(message);
}

class FireException extends AppExceptions {
  FireException({required String message}) : super(message);
}
