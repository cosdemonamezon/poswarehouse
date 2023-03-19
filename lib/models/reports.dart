import 'package:json_annotation/json_annotation.dart';

part 'reports.g.dart';

@JsonSerializable()
class Reports {
  final String month;
  final String month_th;
  final int item;
  final int price;

  Reports(
    this.month,
    this.month_th,
    this.item,
    this.price,
  );

  factory Reports.fromJson(Map<String, dynamic> json) => _$ReportsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportsToJson(this);
}
