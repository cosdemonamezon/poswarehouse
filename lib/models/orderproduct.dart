import 'package:json_annotation/json_annotation.dart';

part 'orderproduct.g.dart';

@JsonSerializable()
class OrderProduct {
  final int? id;
  final String? order_no;
  final int? client_id;
  final String? order_date;
  final String? type;
  final String? status;
  final int? selling_price;
  final String? created_at;
  final String? updated_at;
  

  OrderProduct( 
    this.id,
    this.order_no,
    this.client_id,
    this.order_date,
    this.type,
    this.status,
    this.selling_price,
    this.created_at,
    this.updated_at,
  );

  factory OrderProduct.fromJson(Map<String, dynamic> json) => _$OrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductToJson(this);
}
