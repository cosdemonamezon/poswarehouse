// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Printer _$PrinterFromJson(Map<String, dynamic> json) => Printer(
      json['confirmOrder'] == null
          ? null
          : ConfirmOrder.fromJson(json['confirmOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrinterToJson(Printer instance) => <String, dynamic>{
      'confirmOrder': instance.confirmOrder,
    };
