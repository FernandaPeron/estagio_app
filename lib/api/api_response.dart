class ApiResponse<T> {
  bool isOk;
  String msg;
  T result;

  ApiResponse.ok({this.result, this.msg}) {
    isOk = true;
  }

  ApiResponse.error({this.result, this.msg}) {
    isOk = false;
  }
}
