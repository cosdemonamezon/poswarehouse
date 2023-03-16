import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/typeProduct.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
  final int current_page;
  final List<Order>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? next_page_url;
  final int? per_page;
  final int? to;
  final int? total;

  Orders(
    this.current_page,
    this.data,
    this.first_page_url,
    this.from,
    this.last_page,
    this.last_page_url,
    this.next_page_url,
    this.per_page,
    this.to,
    this.total
  );

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
