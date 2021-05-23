// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillsId _$SkillsIdFromJson(Map<String, dynamic> json) {
  return SkillsId(
    id: json['id'] as int,
    title: json['title'] as String ?? '',
  );
}

Map<String, dynamic> _$SkillsIdToJson(SkillsId instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
