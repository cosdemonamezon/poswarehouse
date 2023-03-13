import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/damageds.dart';

part 'reciveorder.g.dart';

@JsonSerializable()
class Reciveorder {
  String stock_purchase_no;
  Damageds damageds;

  Reciveorder(
    this.stock_purchase_no,
    this.damageds,
  );

  factory Reciveorder.fromJson(Map<String, dynamic> json) => _$ReciveorderFromJson(json);

  Map<String, dynamic> toJson() => _$ReciveorderToJson(this);
}
