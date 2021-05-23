import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class BaseModelResponse {
  bool status;
  String detail;

  BaseModelResponse({this.status, this.detail});

  factory BaseModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelResponseToJson(this);
}
