import 'package:json_annotation/json_annotation.dart';

part 'damageds.g.dart';

@JsonSerializable()
class Damageds {
  int? stock_purchase_line_id;
  String? remark;

  Damageds(
    this.stock_purchase_line_id,
    this.remark,
  );

  factory Damageds.fromJson(Map<String, dynamic> json) => _$DamagedsFromJson(json);

  Map<String, dynamic> toJson() => _$DamagedsToJson(this);
}
