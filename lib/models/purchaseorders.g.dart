// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchaseorders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseOrders _$PurchaseOrdersFromJson(Map<String, dynamic> json) =>
    PurchaseOrders(
      json['id'] as int?,
      json['stock_purchase_no'] as String?,
      json['purchase_date'] as String?,
      json['status'] as String?,
      json['remark'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseOrdersToJson(PurchaseOrders instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stock_purchase_no': instance.stock_purchase_no,
      'purchase_date': instance.purchase_date,
      'status': instance.status,
      'remark': instance.remark,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'orders': instance.orders,
    };
