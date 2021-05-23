import 'package:json_annotation/json_annotation.dart';

part 'burn_stacks.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class BurnStacks {
  @JsonKey(name: 'stacks_id', defaultValue: 0)
  int id;
  @JsonKey(defaultValue: "", name: 'stacks_id__title')
  String title;

  BurnStacks({
    this.id,
    this.title,
  });

  factory BurnStacks.fromJson(Map<String, dynamic> json) =>
      _$BurnStacksFromJson(json);

  Map<String, dynamic> toJson() => _$BurnStacksToJson(this);
}
