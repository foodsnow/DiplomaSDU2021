// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeveloperId _$DeveloperIdFromJson(Map<String, dynamic> json) {
  return DeveloperId(
    id: json['id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeveloperIdToJson(DeveloperId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
    };
