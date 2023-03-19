import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/report.dart';

part 'homereport.g.dart';

@JsonSerializable()
class HomeReport {
  final List<Report> report;

  HomeReport(
    this.report,
  );

  factory HomeReport.fromJson(Map<String, dynamic> json) => _$HomeReportFromJson(json);

  Map<String, dynamic> toJson() => _$HomeReportToJson(this);
}
