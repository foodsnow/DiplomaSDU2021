import 'dart:convert';

class SendOtpResponse {
  bool status;
  String detail;
  String token;
  bool registered;
  int role;

  SendOtpResponse(
      {this.status, this.detail, this.token, this.registered, this.role});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'detail': detail,
      'token': token,
      'registered': registered,
      'role': role
    };
  }

  factory SendOtpResponse.fromMap(Map<String, dynamic> map) {
    return SendOtpResponse(
        status: map['status'] ? true : map['status'],
        detail: map['detail'] as String,
        token: map['token'] as String,
        registered: map['registered'] as bool,
        role: map["role"] == null ? 0 : map["role"] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory SendOtpResponse.fromJson(String source) =>
      SendOtpResponse.fromMap(json.decode(source));
}
