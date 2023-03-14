// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmOrder _$ConfirmOrderFromJson(Map<String, dynamic> json) => ConfirmOrder(
      json['id'] as int,
      json['order_no'] as String?,
      json['client_id'] as int?,
      json['order_date'] as String?,
      json['type'] as String?,
      json['status'] as String?,
      json['payment'] as String?,
      json['amount'] as int?,
      json['selling_price'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['change'] as int?,
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfirmOrderToJson(ConfirmOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.order_no,
      'client_id': instance.client_id,
      'order_date': instance.order_date,
      'type': instance.type,
      'status': instance.status,
      'payment': instance.payment,
      'amount': instance.amount,
      'selling_price': instance.selling_price,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'change': instance.change,
      'client': instance.client,
      'orders': instance.orders,
    };
