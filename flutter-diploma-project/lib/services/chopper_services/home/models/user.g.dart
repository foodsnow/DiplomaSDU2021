// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String ?? '',
    surname: json['surname'] as String ?? '',
    birthDate: json['birth_date'] as String ?? '',
    gender: json['gender'] as int ?? 3,
    role: json['role'] as int ?? 3,
    city: json['city'] as String ?? '',
    phone: json['phone'] as String ?? '',
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
      'role': instance.role,
      'city': instance.city,
      'phone': instance.phone,
    };
