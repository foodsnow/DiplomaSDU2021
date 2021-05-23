import 'package:json_annotation/json_annotation.dart';
part 'skills_id.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class SkillsId {
  int id;
  @JsonKey(defaultValue: "")
  String title;
  SkillsId({
    this.id,
    this.title,
  });

  factory SkillsId.fromJson(Map<String, dynamic> json) =>
      _$SkillsIdFromJson(json);

  Map<String, dynamic> toJson() => _$SkillsIdToJson(this);
}
