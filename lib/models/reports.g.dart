// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reports _$ReportsFromJson(Map<String, dynamic> json) => Reports(
      json['month'] as String,
      json['month_th'] as String,
      json['item'] as int,
      json['price'] as int,
    );

Map<String, dynamic> _$ReportsToJson(Reports instance) => <String, dynamic>{
      'month': instance.month,
      'month_th': instance.month_th,
      'item': instance.item,
      'price': instance.price,
    };
