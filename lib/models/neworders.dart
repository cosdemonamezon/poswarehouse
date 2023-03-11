import 'package:json_annotation/json_annotation.dart';

part 'neworders.g.dart';

@JsonSerializable()
class NewOrders {
  String product_id;
  int? qty;
  int price;

  NewOrders(
    this.product_id,
    this.qty,
    this.price,
  );

  factory NewOrders.fromJson(Map<String, dynamic> json) => _$NewOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrdersToJson(this);
}
