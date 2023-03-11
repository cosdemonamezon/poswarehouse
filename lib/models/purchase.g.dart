// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Purchase _$PurchaseFromJson(Map<String, dynamic> json) => Purchase(
      json['created_at'] as String?,
      json['id'] as int?,
      json['purchase_date'] as String?,
      json['status'] as String?,
      json['stock_purchase_no'] as String?,
      json['updated_at'] as String?,
      json['No'] as int?,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseToJson(Purchase instance) => <String, dynamic>{
      'stock_purchase_no': instance.stock_purchase_no,
      'purchase_date': instance.purchase_date,
      'status': instance.status,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
      'No': instance.No,
      'product': instance.product,
    };
