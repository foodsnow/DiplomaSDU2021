// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Respond _$RespondFromJson(Map<String, dynamic> json) {
  return Respond(
    id: json['id'] as int,
    acceptBool: json['accept_bool'] as bool,
    developerId: json['developer_id'] == null
        ? null
        : DeveloperId.fromJson(json['developer_id'] as Map<String, dynamic>),
    burnProjectId: json['burn_project_id'] as int ?? 0,
    stacksId: json['stacks_id'] as int ?? 0,
  );
}

Map<String, dynamic> _$RespondToJson(Respond instance) => <String, dynamic>{
      'id': instance.id,
      'accept_bool': instance.acceptBool,
      'developer_id': instance.developerId?.toJson(),
      'burn_project_id': instance.burnProjectId,
      'stacks_id': instance.stacksId,
    };
