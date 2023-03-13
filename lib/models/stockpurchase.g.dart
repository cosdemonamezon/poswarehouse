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
      json['pick_out_date'] as String?,
      json['status'] as String?,
      json['remark'] as String?,
      json['stock_purchase_no'] as String?,
      json['stock_pick_out_no'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$StockPurchaseToJson(StockPurchase instance) =>
    <String, dynamic>{
      'stock_purchase_no': instance.stock_purchase_no,
      'stock_pick_out_no': instance.stock_pick_out_no,
      'purchase_date': instance.purchase_date,
      'pick_out_date': instance.pick_out_date,
      'status': instance.status,
      'remark': instance.remark,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
    };
