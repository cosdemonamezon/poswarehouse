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
    await SunmiPrinter.printText('บริษัทอาชาเทค คอเปอเรชั่น จำกัด',);
    await SunmiPrinter.setCustomFontSize(16);
    await SunmiPrinter.printText(
        '64/99 ถนนกาญจนาภิเษก แขวงดอกไม้ เขตประเวศ กรุงเทพมหานคร 10250 โทร 0959405526',);
    //await SunmiPrinter.line();
    await SunmiPrinter.setCustomFontSize(16);
    //await SunmiPrinter.printText('${printer.name}   38      100',);
    await SunmiPrinter.printText('ดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดดด',);

    // await SunmiPrinter.setCustomFontSize(16);
    // await SunmiPrinter.printRow(
    //   cols: [
    //     ColumnMaker(
    //       text: 'บริษัทอาชาเทค',
    //       width: 20,
    //       align: SunmiPrintAlign.LEFT,
    //     ),
    //   ]
    // );
    
    
    await SunmiPrinter.line();

    await SunmiPrinter.lineWrap(5);
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