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

    //Uint8List byte = await _getImageFromAsset('assets/images/asha.jpg');
    // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    // await SunmiPrinter.printImage(byte);
    // await SunmiPrinter.setCustomFontSize(16);
    await SunmiPrinter.printText(
      'บริษัทอาชาเทค คอเปอเรชั่น จำกัด',
    );
    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.printText(
      '64/99 ถนนกาญจนาภิเษก แขวงดอกไม้ เขตประเวศ กรุงเทพมหานคร 10250 โทร 0959405526',
    );
    //await SunmiPrinter.line();

    await SunmiPrinter.setCustomFontSize(16);
    await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          text: 'Product Cose',
          width: 30,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: 'Qty',
          width: 6,
          align: SunmiPrintAlign.RIGHT,
        ),
        ColumnMaker(
          text: 'Price}',
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
    await SunmiPrinter.setCustomFontSize(16);
    for (var i = 0; i < printer.confirmOrder!.orders!.length; i++) {
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          text: '${printer.confirmOrder!.orders![i].product!.code}',
          width: 30,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: '${printer.confirmOrder!.orders![i].qty}',
          width: 6,
          align: SunmiPrintAlign.RIGHT,
        ),
        ColumnMaker(
          text: '${printer.confirmOrder!.orders![i].price_per_unit}',
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
    }
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText(
      'Thank you' 
    );

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