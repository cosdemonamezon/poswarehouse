import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String? stock_purchase_no;
  final String? stock_pick_out_no;
  final String? order_no;
  final String? product_id;
  final String? unit_id;
  final String? cost;
  final String? code;
  final String? price_per_unit;
  final String? price;
  final String? qty;
  String? remark;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;
  final String? status;
  final String? purchase_date;
  final Product? product;
  final List<Order>? orders;
  bool? selected;
  final int? No;

  Order(
    this.id,
    this.stock_purchase_no,
    this.stock_pick_out_no,
    this.order_no,
    this.product_id,
    this.unit_id,
    this.cost,
    this.code,
    this.price_per_unit,
    this.price,
    this.qty,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.deleted_at,
    this.product,
    this.selected,
    this.purchase_date,
    this.No,
    this.status,
    this.orders,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
