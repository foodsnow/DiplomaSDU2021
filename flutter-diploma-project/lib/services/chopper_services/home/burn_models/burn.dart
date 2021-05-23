import 'package:json_annotation/json_annotation.dart';

import 'burn_stacks.dart';

part 'burn.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Burn {
  int id;
  @JsonKey(defaultValue: "")
  String title;
  @JsonKey(name: 'stacks_id', defaultValue: [])
  List<BurnStacks> stacksId;
  @JsonKey(name: 'description', defaultValue: "")
  String description;
  @JsonKey(defaultValue: "")
  String deadline;
  @JsonKey(name: 'user_id', defaultValue: 0)
  int userId;
  @JsonKey(name: 'file_doc', defaultValue: "")
  String fileDoc;

  Burn(
      {this.id,
      this.title,
      this.stacksId,
      this.description,
      this.deadline,
      this.userId,
      this.fileDoc});

  factory Burn.fromJson(Map<String, dynamic> json) => _$BurnFromJson(json);

  Map<String, dynamic> toJson() => _$BurnToJson(this);
}
