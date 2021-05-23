import 'package:json_annotation/json_annotation.dart';
part 'dev_service.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class DevService {
  int id;
  @JsonKey(name: 'service_title', defaultValue: "")
  String serviceTitle;
  @JsonKey(name: 'service_description', defaultValue: "")
  String serviceDescription;
  @JsonKey(defaultValue: 0.0)
  int price;
  @JsonKey(name: 'price_fix', defaultValue: false)
  bool priceFix;
  DevService({
    this.id,
    this.serviceTitle,
    this.serviceDescription,
    this.price,
    this.priceFix,
  });

  factory DevService.fromJson(Map<String, dynamic> json) =>
      _$DevServiceFromJson(json);

  Map<String, dynamic> toJson() => _$DevServiceToJson(this);
}
