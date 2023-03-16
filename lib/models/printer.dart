import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/confirmorder.dart';

part 'printer.g.dart';

@JsonSerializable()
class Printer {
  final ConfirmOrder? confirmOrder;

  Printer(
    this.confirmOrder
  );

  factory Printer.fromJson(Map<String, dynamic> json) => _$PrinterFromJson(json);

  Map<String, dynamic> toJson() => _$PrinterToJson(this);
}
