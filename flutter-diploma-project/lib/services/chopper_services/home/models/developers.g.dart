// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Developers _$DevelopersFromJson(Map<String, dynamic> json) {
  return Developers(
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Developer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DevelopersToJson(Developers instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };
