// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neworders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrders _$NewOrdersFromJson(Map<String, dynamic> json) => NewOrders(
      json['product_id'] as String,
      json['qty'] as int?,
      json['price'] as int,
      json['unit_id'] as int,
      json['unit'] == null
          ? null
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      json['selected'] as bool,
    );

Map<String, dynamic> _$NewOrdersToJson(NewOrders instance) => <String, dynamic>{
      'product_id': instance.product_id,
      'qty': instance.qty,
      'price': instance.price,
      'unit_id': instance.unit_id,
      'unit': instance.unit,
      'product': instance.product,
      'selected': instance.selected,
    };
