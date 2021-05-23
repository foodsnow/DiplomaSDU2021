import 'dart:convert';

class BaseResponse {
  bool status;
  String detail;

  BaseResponse({this.status, this.detail});

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      status: map['status'] as bool,
      detail: map['detail'] as String,
    );
  }

  factory BaseResponse.fromJson(String source) =>
      BaseResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {'status': status, 'detail': detail};
  }

  String toJson() => json.encode(toMap());
}
