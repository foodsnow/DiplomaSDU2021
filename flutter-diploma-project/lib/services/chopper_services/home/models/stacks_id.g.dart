// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stacks_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StacksId _$StacksIdFromJson(Map<String, dynamic> json) {
  return StacksId(
    id: json['id'] as int ?? 0,
    title: json['title'] as String ?? '',
  );
}

Map<String, dynamic> _$StacksIdToJson(StacksId instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
