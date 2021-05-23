import 'package:diploma_flutter_app/services/chopper_services/home/models/dev_service.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/skills_id.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/stacks_id.dart';
import 'package:diploma_flutter_app/services/chopper_services/home/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'developer.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Developer {
  int id;
  User user;
  @JsonKey(defaultValue: "")
  String education;
  @JsonKey(name: 'dev_service', defaultValue: null)
  DevService devService;
  @JsonKey(name: 'stacks_id', defaultValue: null)
  StacksId stacksId;
  @JsonKey(name: 'skills_id', defaultValue: [])
  List<SkillsId> skillsId;
  @JsonKey(name: 'work_experience', defaultValue: "")
  String workExperience;
  @JsonKey(name: 'rating', defaultValue: 0.0)
  double rating;
  @JsonKey(name: 'rating_count', defaultValue: 0)
  int ratingCount;
  @JsonKey(name: 'price', defaultValue: 0.0)
  double price;
  @JsonKey(defaultValue: "")
  String about;
  @JsonKey(defaultValue: false, name: 'is_favorite')
  bool isFavorite;
  Developer({
    this.id,
    this.user,
    this.education,
    this.devService,
    this.stacksId,
    this.skillsId,
    this.workExperience,
    this.about,
    this.isFavorite
  });

  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);

  Map<String, dynamic> toJson() => _$DeveloperToJson(this);
}
