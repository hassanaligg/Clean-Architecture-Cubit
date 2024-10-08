class EmptyResponse {
  bool? succeed;
  String? message;

  EmptyResponse({
    this.succeed,
    this.message,
  });

  EmptyResponse.fromJson(Map<String, dynamic> json) {
    succeed = json['succeed'];
    message = json['message'];
  }
}
