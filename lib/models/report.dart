import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/reports.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  final int total1;
  final int total2;
  final int total3;
  final int total4;
  final List<Reports> orders;

  Report(
    this.total1,
    this.total2,
    this.total3,
    this.total4,
    this.orders
  );

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
