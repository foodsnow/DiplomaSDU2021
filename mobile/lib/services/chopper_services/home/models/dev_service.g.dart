// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevService _$DevServiceFromJson(Map<String, dynamic> json) {
  return DevService(
    id: json['id'] as int,
    serviceTitle: json['service_title'] as String ?? '',
    serviceDescription: json['service_description'] as String ?? '',
    price: json['price'] as int ?? 0.0,
    priceFix: json['price_fix'] as bool ?? false,
  );
}

Map<String, dynamic> _$DevServiceToJson(DevService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_title': instance.serviceTitle,
      'service_description': instance.serviceDescription,
      'price': instance.price,
      'price_fix': instance.priceFix,
    };
