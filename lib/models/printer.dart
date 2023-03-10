import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/confirmorder.dart';

part 'printer.g.dart';

@JsonSerializable()
class Printer {
  final String? name;
  final String? date;
  final String? time;
  final String? qty;
  final String? total;
  final String? balance;
  final ConfirmOrder? confirmOrder;

  Printer(
    this.name,
    this.date,
    this.time,
    this.qty,
    this.total,
    this.balance,
    this.confirmOrder
  );

  factory Printer.fromJson(Map<String, dynamic> json) => _$PrinterFromJson(json);

  Map<String, dynamic> toJson() => _$PrinterToJson(this);
}
