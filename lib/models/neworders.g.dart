// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neworders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrders _$NewOrdersFromJson(Map<String, dynamic> json) => NewOrders(
      json['product_id'] as String,
      json['qty'] as int,
      json['price'] as int,
    );

Map<String, dynamic> _$NewOrdersToJson(NewOrders instance) => <String, dynamic>{
      'product_id': instance.product_id,
      'qty': instance.qty,
      'price': instance.price,
    };
