class ApiResponse<T>{
  late T? data;
  late bool error;
  late String? errorMessage;
  ApiResponse({this.data, this.error=false, this.errorMessage});
}