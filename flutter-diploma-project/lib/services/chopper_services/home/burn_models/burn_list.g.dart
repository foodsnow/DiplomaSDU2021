// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'burn_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BurnList _$BurnListFromJson(Map<String, dynamic> json) {
  return BurnList(
    results: (json['results'] as List)
        ?.map(
            (e) => e == null ? null : Burn.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BurnListToJson(BurnList instance) => <String, dynamic>{
      'results': instance.results?.map((e) => e?.toJson())?.toList(),
    };
