class ApiResponse<T>{
  late T? data;
  late bool error;
  late String? errorMessage;
  late int? statusCode;
  ApiResponse({this.data, this.error=false, this.errorMessage, this.statusCode});


  where(bool Function(dynamic schedule) param0) {}
}