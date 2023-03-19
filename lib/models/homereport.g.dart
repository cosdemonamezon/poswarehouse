// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homereport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeReport _$HomeReportFromJson(Map<String, dynamic> json) => HomeReport(
      (json['report'] as List<dynamic>)
          .map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeReportToJson(HomeReport instance) =>
    <String, dynamic>{
      'report': instance.report,
    };
