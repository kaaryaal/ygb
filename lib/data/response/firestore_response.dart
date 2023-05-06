import 'package:fitness_app_mvvm/data/response/status.dart';

class FirestoreResponse<T> {
  Status? status;
  T? data;
  String? message;

  FirestoreResponse(this.status, this.data, this.message);

  FirestoreResponse.loading() : status = Status.LOADING;

  FirestoreResponse.completed(this.data) : status = Status.COMPLETED;

  FirestoreResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
