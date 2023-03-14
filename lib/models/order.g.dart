// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['id'] as int,
      json['stock_purchase_no'] as String?,
      json['stock_pick_out_no'] as String?,
      json['order_no'] as String?,
      json['product_id'] as int?,
      json['unit_id'] as int?,
      json['cost'] as String?,
      json['code'] as String?,
      json['price_per_unit'] as String?,
      json['price'] as int?,
      json['qty'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'stock_purchase_no': instance.stock_purchase_no,
      'stock_pick_out_no': instance.stock_pick_out_no,
      'order_no': instance.order_no,
      'product_id': instance.product_id,
      'unit_id': instance.unit_id,
      'cost': instance.cost,
      'code': instance.code,
      'price_per_unit': instance.price_per_unit,
      'price': instance.price,
      'qty': instance.qty,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
      'product': instance.product,
    };
