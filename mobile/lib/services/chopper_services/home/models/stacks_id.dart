import 'package:json_annotation/json_annotation.dart';
part 'stacks_id.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class StacksId {
  @JsonKey(defaultValue: 0)
  int id;
  @JsonKey(defaultValue: "")
  String title;
  StacksId({
    this.id,
    this.title,
  });

  factory StacksId.fromJson(Map<String, dynamic> json) =>
      _$StacksIdFromJson(json);

  Map<String, dynamic> toJson() => _$StacksIdToJson(this);
}
