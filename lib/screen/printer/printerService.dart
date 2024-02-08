import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poswarehouse/models/printer.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class PrinterService {
  const PrinterService();

  Future<void> print(Printer printer) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    const utf8Encoder = Utf8Encoder();

    //Uint8List byte = await _getImageFromAsset('assets/images/asha.jpg');
    // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    // await SunmiPrinter.printImage(byte);
    // await SunmiPrinter.setCustomFontSize(16);
    await SunmiPrinter.printText(
      'ร้าน โคตรถูก!!',
    );
    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.printText(
      'ที่อยู่ 34/5 ตำบล มุกดาหาร อำเภอ เมืองมุกดาหาร จังหวัดมุกดาหาร 49000 \nโทร 083 770 7608\nโทร 099 423 2484',
    );
    await SunmiPrinter.line();
    await SunmiPrinter.printText(
      'ชื่อ  ${printer.confirmOrder!.client!.name ?? '-'}',
    );
    await SunmiPrinter.printText(
      'เบอร์โทร  ${printer.confirmOrder!.client!.phone}',
    );

    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: 'Product Code',
        width: 27,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: 'Qty',
        width: 6,
        align: SunmiPrintAlign.RIGHT,
      ),
      ColumnMaker(
        text: 'Price',
        width: 7,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.setCustomFontSize(18);
    for (var i = 0; i < printer.confirmOrder!.orders!.length; i++) {
      //final encodedStr = utf8Encoder.convert('${printer.confirmOrder!.orders![i].product!.name}');

      int qty = int.parse('${printer.confirmOrder!.orders![i].qty}');
      double price = double.parse('${printer.confirmOrder!.orders![i].price_per_unit}');
      double price_per_unit = price * qty;
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          text: '${printer.confirmOrder!.orders![i].product!.code}',
          width: 27,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: '${printer.confirmOrder!.orders![i].qty}',
          width: 6,
          align: SunmiPrintAlign.RIGHT,
        ),
        ColumnMaker(
          text: '${price_per_unit}',
          //text: '${printer.confirmOrder!.orders![i].price_per_unit}',
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
    }
    await SunmiPrinter.line();

    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: 'Total',
        width: 27,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: '',
        width: 6,
        align: SunmiPrintAlign.RIGHT,
      ),
      ColumnMaker(
        text: '${printer.confirmOrder!.selling_price}',
        width: 7,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: 'Amount',
        width: 27,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: '',
        width: 6,
        align: SunmiPrintAlign.RIGHT,
      ),
      ColumnMaker(
        text: '${printer.confirmOrder!.amount}',
        width: 7,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: 'Change',
        width: 27,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: '',
        width: 6,
        align: SunmiPrintAlign.RIGHT,
      ),
      ColumnMaker(
        text: '${printer.confirmOrder!.change}',
        width: 7,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Thank you');

    await SunmiPrinter.line();

    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.exitTransactionPrint(true);
  }
}

// Future<Uint8List> readFileBytes(String path) async {
//   ByteData fileData = await rootBundle.load(path);
//   Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
//   return fileUnit8List;
// }

// Future<Uint8List> _getImageFromAsset(String iconPath) async {
//   return await readFileBytes(iconPath);
// }