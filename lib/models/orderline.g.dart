// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orderline _$OrderlineFromJson(Map<String, dynamic> json) => Orderline(
      json['id'] as int,
      json['order_no'] as String?,
      json['product_id'] as String?,
      json['unit_id'] as String?,
      json['cost'] as String?,
      json['price_per_unit'] as String?,
      json['qty'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderlineToJson(Orderline instance) => <String, dynamic>{
      'id': instance.id,
      'order_no': instance.order_no,
      'product_id': instance.product_id,
      'unit_id': instance.unit_id,
      'cost': instance.cost,
      'price_per_unit': instance.price_per_unit,
      'qty': instance.qty,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
      'product': instance.product,
    };
