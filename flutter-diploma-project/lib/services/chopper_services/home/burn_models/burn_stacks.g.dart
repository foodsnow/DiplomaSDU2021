// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burn_stacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BurnStacks _$BurnStacksFromJson(Map<String, dynamic> json) {
  return BurnStacks(
    id: json['stacks_id'] as int ?? 0,
    title: json['stacks_id__title'] as String ?? '',
  );
}

Map<String, dynamic> _$BurnStacksToJson(BurnStacks instance) =>
    <String, dynamic>{
      'stacks_id': instance.id,
      'stacks_id__title': instance.title,
    };
