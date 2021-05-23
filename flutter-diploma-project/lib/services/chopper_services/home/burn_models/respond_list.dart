import 'package:diploma_flutter_app/services/chopper_services/home/burn_models/respond.dart';
import 'package:json_annotation/json_annotation.dart';

part 'respond_list.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class RespondList {
  List<Respond> results;

  RespondList({this.results});

  factory RespondList.fromJson(Map<String, dynamic> json) =>
      _$RespondListFromJson(json);

  Map<String, dynamic> toJson() => _$RespondListToJson(this);
}
