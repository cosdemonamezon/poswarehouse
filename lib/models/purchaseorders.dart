import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/product.dart';

part 'purchaseorders.g.dart';

@JsonSerializable()
class PurchaseOrders {
  final int? id;
  final String? stock_purchase_no;
  final String? purchase_date;
  final String? status;
  final String? remark;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final List<Order>? orders;
  

  PurchaseOrders(    
    this.id,
    this.stock_purchase_no,
    this.purchase_date,
    this.status,
    this.remark,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.orders
  );

  factory PurchaseOrders.fromJson(Map<String, dynamic> json) => _$PurchaseOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseOrdersToJson(this);
}
