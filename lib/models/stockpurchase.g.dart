// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stockpurchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockPurchase _$StockPurchaseFromJson(Map<String, dynamic> json) =>
    StockPurchase(
      json['created_at'] as String?,
      json['id'] as int?,
      json['purchase_date'] as String?,
      json['status'] as String?,
      json['stock_purchase_no'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$StockPurchaseToJson(StockPurchase instance) =>
    <String, dynamic>{
      'stock_purchase_no': instance.stock_purchase_no,
      'purchase_date': instance.purchase_date,
      'status': instance.status,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
    };
