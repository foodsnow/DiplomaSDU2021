class OtpResponse {
  bool status;
  String detail;
  int key;

  OtpResponse({this.status, this.detail, this.key});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'] as bool,
      detail: json['detail'] as String,
      key: json['key'] as int,
    );
  }
  Map<String, dynamic> toJson() =>
      {'status': status, 'detail': detail, 'key': key};
}
