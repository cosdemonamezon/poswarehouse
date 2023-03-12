import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  final String? stock_purchase_no;
  final String? product_id;
  final String? price;
  final String? qty;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final String? deleted_at;
  

  Order(    
    this.id,
    this.stock_purchase_no,
    this.product_id,
    this.price,
    this.qty,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.deleted_at
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
