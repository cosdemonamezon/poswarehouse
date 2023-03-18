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
      json['client_id'] as String?,
      json['type'] as String?,
      json['status'] as String?,
      json['payment'] as String?,
      json['amount'] as String?,
      json['selling_price'] as String?,
      json['product_id'] as String?,
      json['unit_id'] as String?,
      json['cost'] as String?,
      json['code'] as String?,
      json['price_per_unit'] as String?,
      json['price'] as String?,
      json['qty'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['deleted_at'] as String?,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      json['selected'] as bool?,
      (json['order_lines'] as List<dynamic>?)
          ?.map((e) => Orderline.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['purchase_date'] as String?,
      json['No'] as int?,
      (json['pick_out_lines'] as List<dynamic>?)
          ?.map((e) => ReceivingGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..remark = json['remark'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'stock_purchase_no': instance.stock_purchase_no,
      'stock_pick_out_no': instance.stock_pick_out_no,
      'order_no': instance.order_no,
      'client_id': instance.client_id,
      'type': instance.type,
      'status': instance.status,
      'payment': instance.payment,
      'amount': instance.amount,
      'selling_price': instance.selling_price,
      'product_id': instance.product_id,
      'unit_id': instance.unit_id,
      'cost': instance.cost,
      'code': instance.code,
      'price_per_unit': instance.price_per_unit,
      'price': instance.price,
      'qty': instance.qty,
      'remark': instance.remark,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'deleted_at': instance.deleted_at,
      'purchase_date': instance.purchase_date,
      'product': instance.product,
      'orders': instance.orders,
      'selected': instance.selected,
      'order_lines': instance.order_lines,
      'pick_out_lines': instance.pick_out_lines,
      'No': instance.No,
    };
