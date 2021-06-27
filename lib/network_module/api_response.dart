class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.complete(this.data) : status = Status.COMPLETE;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'Status : $status \n Message $message \n Data $data';
  }
}

enum Status { LOADING, COMPLETE, ERROR }
