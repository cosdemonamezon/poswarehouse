// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciveorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reciveorder _$ReciveorderFromJson(Map<String, dynamic> json) => Reciveorder(
      json['stock_purchase_no'] as String,
      Damageds.fromJson(json['damageds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReciveorderToJson(Reciveorder instance) =>
    <String, dynamic>{
      'stock_purchase_no': instance.stock_purchase_no,
      'damageds': instance.damageds,
    };
