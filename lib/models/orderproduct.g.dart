// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      json['id'] as int?,
      json['order_no'] as String?,
      json['client_id'] as int?,
      json['order_date'] as String?,
      json['type'] as String?,
      json['status'] as String?,
      json['selling_price'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.order_no,
      'client_id': instance.client_id,
      'order_date': instance.order_date,
      'type': instance.type,
      'status': instance.status,
      'selling_price': instance.selling_price,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
