// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      json['total1'] as int,
      json['total2'] as int,
      json['total3'] as int,
      json['total4'] as int,
      (json['orders'] as List<dynamic>)
          .map((e) => Reports.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'total1': instance.total1,
      'total2': instance.total2,
      'total3': instance.total3,
      'total4': instance.total4,
      'orders': instance.orders,
    };
