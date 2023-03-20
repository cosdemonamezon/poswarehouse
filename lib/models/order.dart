import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/orderline.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/receivinggoods.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  final String? stock_purchase_no;
  final String? stock_pick_out_no;
  final String? order_no;
  final String? client_id;
  final String? type;
  final String? status;
  final String? payment;
  final String? amount;
  final String? selling_price;
  final String? product_id;
  final String? unit_id;
  final String? cost;
  final String? code;
  final String? price_per_unit;
  final String? price;
  String? qty;
  String? remark;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;
  final String? purchase_date;
  final Product? product;
  final List<Order>? orders;
  bool? selected;
  List<Orderline>? order_lines;
  List<ReceivingGoods>? pick_out_lines;
  final int? No;

  Order(
    this.id,
    this.stock_purchase_no,
    this.stock_pick_out_no,
    this.order_no,
    this.client_id,
    this.type,
    this.status,
    this.payment,
    this.amount,
    this.selling_price,
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
    this.order_lines,
    this.purchase_date,
    this.No,
    this.pick_out_lines,
    this.orders,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
