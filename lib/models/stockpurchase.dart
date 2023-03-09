import 'package:json_annotation/json_annotation.dart';

part 'stockpurchase.g.dart';

@JsonSerializable()
class StockPurchase {
  final String? stock_purchase_no;
  final String? purchase_date;
  final String? status;
  final String? updated_at;
  final String? created_at;
  final int? id;

  StockPurchase(
    this.created_at,
    this.id,
    this.purchase_date,
    this.status,
    this.stock_purchase_no,
    this.updated_at
  );

  factory StockPurchase.fromJson(Map<String, dynamic> json) => _$StockPurchaseFromJson(json);

  Map<String, dynamic> toJson() => _$StockPurchaseToJson(this);
}
