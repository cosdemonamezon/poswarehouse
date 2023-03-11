import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';

part 'purchase.g.dart';

@JsonSerializable()
class Purchase {
  final String? stock_purchase_no;
  final String? purchase_date;
  final String? status;
  final String? updated_at;
  final String? created_at;
  final int? id;
  final int? No;
  final Product? product;

  Purchase(
    this.created_at,
    this.id,
    this.purchase_date,
    this.status,
    this.stock_purchase_no,
    this.updated_at,
    this.No,
    this.product
  );

  factory Purchase.fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseToJson(this);
}
