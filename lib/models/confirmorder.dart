import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/client.dart';
import 'package:poswarehouse/models/order.dart';

part 'confirmorder.g.dart';

@JsonSerializable()
class ConfirmOrder {
  final int id;
  final String? order_no;
  final int? client_id;
  final String? order_date;
  final String? type;
  final String? status;
  final String? payment;
  final String? amount;
  final int? selling_price;
  final String? created_at;
  final String? updated_at;
  final int? change;
  final Client? client;
  List<Order>? orders;
  

  ConfirmOrder( 
    this.id,
    this.order_no,
    this.client_id,
    this.order_date,
    this.type,
    this.status,
    this.payment,
    this.amount,
    this.selling_price,
    this.created_at,
    this.updated_at,
    this.change,
    this.client,
    this.orders
  );

  factory ConfirmOrder.fromJson(Map<String, dynamic> json) => _$ConfirmOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOrderToJson(this);
}
