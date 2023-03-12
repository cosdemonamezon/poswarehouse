// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivinggoods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingGoods _$ReceivingGoodsFromJson(Map<String, dynamic> json) =>
    ReceivingGoods(
      json['id'] as int?,
      json['stock_purchase_no'] as String?,
      json['product_id'] as String?,
      json['price'] as String?,
      json['qty'] as String?,
      json['purchase_date'] as String?,
      json['status'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceivingGoodsToJson(ReceivingGoods instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stock_purchase_no': instance.stock_purchase_no,
      'product_id': instance.product_id,
      'price': instance.price,
      'qty': instance.qty,
      'purchase_date': instance.purchase_date,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'product': instance.product,
      'orders': instance.orders,
    };
