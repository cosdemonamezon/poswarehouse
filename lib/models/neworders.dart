import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/unit.dart';

part 'neworders.g.dart';

@JsonSerializable()
class NewOrders {
  String product_id;
  int? qty;
  int? price_per_unit;
  int? cost;
  int? price;
  int unit_id;
  Unit? unit;
  Product? product;
  bool selected = false;

  NewOrders(
      this.product_id,
      this.qty,
      this.cost,
      this.price,
      this.price_per_unit,
      this.unit_id,
      this.unit,
      this.product,
      this.selected);

  factory NewOrders.fromJson(Map<String, dynamic> json) =>
      _$NewOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrdersToJson(this);
}
