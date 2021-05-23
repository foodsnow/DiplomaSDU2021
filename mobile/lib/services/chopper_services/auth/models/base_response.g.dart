// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModelResponse _$BaseModelResponseFromJson(Map<String, dynamic> json) {
  return BaseModelResponse(
    status: json['status'] as bool,
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$BaseModelResponseToJson(BaseModelResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'detail': instance.detail,
    };
