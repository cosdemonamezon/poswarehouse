import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/product.dart';

part 'receivinggoods.g.dart';

@JsonSerializable()
class ReceivingGoods {
  final int? id;
  final String? stock_purchase_no;
  final String? product_id;
  final String? price;
  final String? qty;
  final String? purchase_date;
  final String? status;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final Product? product;
  final List<Order>? orders;
  

  ReceivingGoods(    
    this.id,
    this.stock_purchase_no,
    this.product_id,
    this.price,
    this.qty,
    this.purchase_date,
    this.status,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.product,
    this.orders
  );

  factory ReceivingGoods.fromJson(Map<String, dynamic> json) => _$ReceivingGoodsFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivingGoodsToJson(this);
}
