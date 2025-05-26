import 'package:book_buddy/GetX%20MVVM/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETETD;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Api Response: {status: $status, data: $data, message: $message}';
  }
}
