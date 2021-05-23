import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class User {
  @JsonKey(defaultValue: "")
  String name;
  @JsonKey(defaultValue: "")
  String surname;
  @JsonKey(name: 'birth_date', defaultValue: "")
  String birthDate;
  @JsonKey(defaultValue: 3)
  int gender;
  @JsonKey(defaultValue: 3)
  int role;
  @JsonKey(defaultValue: "")
  String city;
  @JsonKey(defaultValue: "")
  String phone;
  User({
    this.name,
    this.surname,
    this.birthDate,
    this.gender,
    this.role,
    this.city,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
