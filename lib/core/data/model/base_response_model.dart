import 'package:dawaa24/core/data/model/error/error_model.dart';

class BaseResponse<T> {
  final T? data;
  final bool? status;
  final int? code;
  final String? message;
  final ErrorModel? errorModel;

  factory BaseResponse.fromJson({
    required dynamic data,
    T Function(dynamic json)? decoder,
  }) {
    return BaseResponse(
        errorModel:
            (data["error"] != null) ? ErrorModel.fromJson(data["error"]) : null,
        data: decoder?.call(data['data']?['result'] ?? '{}'),
        status: data["status"] ?? false,
        code: data["code"] ?? 0,
        message: data["message"] ?? "");
  }

  @override
  String toString() {
    return 'data: $data \nstatus:$status, \ncode:$code, \nmessage:$message, \nerrorModel:$errorModel';
  }

  BaseResponse(
      {required this.data,
      required this.status,
      required this.code,
      required this.message,
      required this.errorModel});
}

enum ListKeysPage { items, result, data }

class Page<T> {
  final List<T> list;
  final int count;

  factory Page.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) listDecode,
    ListKeysPage key,
  ) {
    return Page(
      list: json[key.name] != null
          ? (json[key.name] as List).map<T>((e) => listDecode.call(e)).toList()
          : [],
      count: json['totalCount'] ?? 0,
    );
  }

  factory Page.fromListJson(
      List<dynamic> json,
      T Function(Map<String, dynamic> json) listDecode,
      ) {
    return Page(
      list: json.map<T>((e) => listDecode.call(e)).toList(),
      count: json.length,
    );
  }

  @override
  String toString() {
    return 'data: ${list.map((e) => '${e.toString()}\n')}';
  }

  Page({
    required this.list,
    required this.count,
  });
}
