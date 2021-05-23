// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respond_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespondList _$RespondListFromJson(Map<String, dynamic> json) {
  return RespondList(
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Respond.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RespondListToJson(RespondList instance) =>
    <String, dynamic>{
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };
