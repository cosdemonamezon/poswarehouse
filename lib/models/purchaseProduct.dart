import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/purchase.dart';

part 'purchaseProduct.g.dart';

@JsonSerializable()
class PurchaseProduct {
  final int current_page;
  List<Purchase>? data;
  final String? first_page_url;
  final int? from;
  final int? last_page;
  final String? last_page_url;
  final String? next_page_url;
  final int? per_page;
  final int? to;
  final int? total;

  PurchaseProduct(this.current_page, this.data, this.first_page_url, this.from, this.last_page, this.last_page_url,
      this.next_page_url, this.per_page, this.to, this.total);

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) => _$PurchaseProductFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseProductToJson(this);
}
