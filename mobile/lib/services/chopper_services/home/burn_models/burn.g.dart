// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Burn _$BurnFromJson(Map<String, dynamic> json) {
  return Burn(
    id: json['id'] as int,
    title: json['title'] as String ?? '',
    stacksId: (json['stacks_id'] as List)
            ?.map((e) => e == null
                ? null
                : BurnStacks.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    description: json['description'] as String ?? '',
    deadline: json['deadline'] as String ?? '',
    userId: json['user_id'] as int ?? 0,
    fileDoc: json['file_doc'] as String ?? '',
  );
}

Map<String, dynamic> _$BurnToJson(Burn instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'stacks_id': instance.stacksId?.map((e) => e?.toJson())?.toList(),
      'description': instance.description,
      'deadline': instance.deadline,
      'user_id': instance.userId,
      'file_doc': instance.fileDoc,
    };
