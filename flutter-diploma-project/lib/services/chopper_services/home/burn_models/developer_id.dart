import 'package:diploma_flutter_app/services/chopper_services/home/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'developer_id.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class DeveloperId {
  int id;
  @JsonKey(name: 'user', defaultValue: null)
  User user;

  DeveloperId({
    this.id,
    this.user,
  });

  factory DeveloperId.fromJson(Map<String, dynamic> json) =>
      _$DeveloperIdFromJson(json);

  Map<String, dynamic> toJson() => _$DeveloperIdToJson(this);
}
