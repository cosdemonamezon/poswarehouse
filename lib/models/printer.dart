import 'package:json_annotation/json_annotation.dart';

part 'printer.g.dart';

@JsonSerializable()
class Printer {
  final String? name;
  final String? date;
  final String? time;
  final String? qty;
  final String? total;
  final String? balance;

  Printer(
    this.name,
    this.date,
    this.time,
    this.qty,
    this.total,
    this.balance
  );

  factory Printer.fromJson(Map<String, dynamic> json) => _$PrinterFromJson(json);

  Map<String, dynamic> toJson() => _$PrinterToJson(this);
}
