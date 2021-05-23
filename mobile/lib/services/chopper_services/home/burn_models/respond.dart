import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/developer_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'respond.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Respond {
  int id;
  @JsonKey(defaultValue: null, name: 'accept_bool')
  bool acceptBool;
  @JsonKey(name: 'developer_id', defaultValue: null)
  DeveloperId developerId;
  @JsonKey(name: 'burn_project_id', defaultValue: 0)
  int burnProjectId;
  @JsonKey(name: 'stacks_id', defaultValue: 0)
  int stacksId;

  Respond(
      {this.id,
      this.acceptBool,
      this.developerId,
      this.burnProjectId,
      this.stacksId});

  factory Respond.fromJson(Map<String, dynamic> json) =>
      _$RespondFromJson(json);

  Map<String, dynamic> toJson() => _$RespondToJson(this);
}
