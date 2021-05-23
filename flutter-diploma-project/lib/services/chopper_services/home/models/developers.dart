import 'package:diploma_flutter_app/services/chopper_services/home/models/developer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'developers.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Developers {
  List<Developer> results;

  Developers({this.results});

  factory Developers.fromJson(Map<String, dynamic> json) =>
      _$DevelopersFromJson(json);
  Map<String, dynamic> toJson() => _$DevelopersToJson(this);
}
