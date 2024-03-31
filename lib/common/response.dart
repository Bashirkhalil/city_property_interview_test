class ResponseResult {
  String? message;

  ResponseResult({this.message});

  ResponseResult.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}