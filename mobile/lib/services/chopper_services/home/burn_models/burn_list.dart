import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/burn.dart';
import 'package:json_annotation/json_annotation.dart';

part 'burn_list.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class BurnList {
  List<Burn> results;

  BurnList({this.results});

  factory BurnList.fromJson(Map<String, dynamic> json) =>
      _$BurnListFromJson(json);

  Map<String, dynamic> toJson() => _$BurnListToJson(this);
}
