import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/product.dart';

part 'receivinggoods.g.dart';

@JsonSerializable()
class ReceivingGoods {
  final int id;
  final String? stock_pick_out_no;
  final String? product_id;
  final String? unit_id;
  final String? price;
  final String? qty;
  final String? pick_out_date;
  final String? status;
  final String? remark;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final Product? product;
  final List<Order>? orders;
  

  ReceivingGoods(    
    this.id,
    this.stock_pick_out_no,
    this.product_id,
    this.unit_id,
    this.price,
    this.qty,
    this.pick_out_date,
    this.status,
    this.remark,
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
