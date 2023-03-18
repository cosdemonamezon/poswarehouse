// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receiving _$ReceivingFromJson(Map<String, dynamic> json) => Receiving(
      json['id'] as int?,
      json['stock_pick_out_no'] as String?,
      json['pick_out_date'] as String?,
      json['stock_purchase_no'] as String?,
      json['remark'] as String?,
      json['status'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['create_by'] as String?,
      json['update_by'] as String?,
      json['No'] as int?,
      (json['pick_out_lines'] as List<dynamic>?)
          ?.map((e) => ReceivingGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      json['unit'] == null
          ? null
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceivingToJson(Receiving instance) => <String, dynamic>{
      'id': instance.id,
      'stock_pick_out_no': instance.stock_pick_out_no,
      'pick_out_date': instance.pick_out_date,
      'stock_purchase_no': instance.stock_purchase_no,
      'remark': instance.remark,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'create_by': instance.create_by,
      'update_by': instance.update_by,
      'No': instance.No,
      'pick_out_lines': instance.pick_out_lines,
      'product': instance.product,
      'unit': instance.unit,
    };
