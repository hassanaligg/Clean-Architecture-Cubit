class ErrorModel {
  ErrorModel({
    required this.code,
    required this.message,
    required this.details,
    required this.data,
    required this.validationErrors,
  });
  final String code;
  final String message;
  final String details;
  final List<UnProcessableErrorModel>? data;
  final List<ValidationError> validationErrors;
  ErrorModel copyWith({
    String? code,
    String? message,
    String? details,
    List<UnProcessableErrorModel>? data,
    List<ValidationError>? validationErrors,
  }) {
    return ErrorModel(
      code: code ?? this.code,
      message: message ?? this.message,
      details: details ?? this.details,
      data: data ?? this.data,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      code: json["code"] ?? "",
      message: json["message"] ?? "",
      details: json["details"] ?? "",
      data: json["data"] == null
          ? null
          : UnProcessableErrorModel.fromJson(json["data"]),
      validationErrors: json["validationErrors"] == null
          ? []
          : List<ValidationError>.from(json["validationErrors"]!
          .map((x) => ValidationError.fromJson(x))),
    );
  }
  @override
  String toString() {
    return "$code, $message, $details, $data, $validationErrors, ";
  }
}
class UnProcessableErrorModel {
  String message;
  UnProcessableErrorModel({required this.message});
  static List<UnProcessableErrorModel> fromJson(Map<String, dynamic> json) {
    final errorMessages = <UnProcessableErrorModel>[];
    json.forEach((key, value) {
      errorMessages.add(UnProcessableErrorModel(message: value));
    });
    return errorMessages;
  }
  @override
  String toString() {
    return "message: $message, ";
  }
}
class ValidationError {
  ValidationError({
    required this.message,
    required this.members,
  });
  final String message;
  final List<String> members;
  ValidationError copyWith({
    String? message,
    List<String>? members,
  }) {
    return ValidationError(
      message: message ?? this.message,
      members: members ?? this.members,
    );
  }
  factory ValidationError.fromJson(Map<String, dynamic> json) {
    return ValidationError(
      message: json["message"] ?? "",
      members: json["members"] == null
          ? []
          : List<String>.from(json["members"]!.map((x) => x)),
    );
  }
  @override
  String toString() {
    return "$message, $members, ";
  }
}