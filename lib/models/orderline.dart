import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';

part 'orderline.g.dart';

@JsonSerializable()
class Orderline {
  final int id;
  final String? order_no;
  final String? product_id;
  final String? unit_id;
  final String? cost;
  final String? price_per_unit;
  final String? qty;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;
  final Product? product;

  Orderline(
    this.id,
    this.order_no,
    this.product_id,
    this.unit_id,
    this.cost,
    this.price_per_unit,
    this.qty,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.deleted_at,
    this.product,
  );

  factory Orderline.fromJson(Map<String, dynamic> json) => _$OrderlineFromJson(json);

  Map<String, dynamic> toJson() => _$OrderlineToJson(this);
}
