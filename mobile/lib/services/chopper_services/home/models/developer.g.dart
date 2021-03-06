// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Developer _$DeveloperFromJson(Map<String, dynamic> json) {
  return Developer(
    id: json['id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    education: json['education'] as String ?? '',
    devService: json['dev_service'] == null
        ? null
        : DevService.fromJson(json['dev_service'] as Map<String, dynamic>),
    stacksId: json['stacks_id'] == null
        ? null
        : StacksId.fromJson(json['stacks_id'] as Map<String, dynamic>),
    skillsId: (json['skills_id'] as List)
            ?.map((e) =>
                e == null ? null : SkillsId.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    workExperience: json['work_experience'] as String ?? '',
    about: json['about'] as String ?? '',
    isFavorite: json['is_favorite'] as bool ?? false,
  )
    ..rating = (json['rating'] as num)?.toDouble() ?? 0.0
    ..ratingCount = json['rating_count'] as int ?? 0
    ..price = (json['price'] as num)?.toDouble() ?? 0.0;
}

Map<String, dynamic> _$DeveloperToJson(Developer instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'education': instance.education,
      'dev_service': instance.devService?.toJson(),
      'stacks_id': instance.stacksId?.toJson(),
      'skills_id': instance.skillsId?.map((e) => e?.toJson())?.toList(),
      'work_experience': instance.workExperience,
      'rating': instance.rating,
      'rating_count': instance.ratingCount,
      'price': instance.price,
      'about': instance.about,
      'is_favorite': instance.isFavorite,
    };
