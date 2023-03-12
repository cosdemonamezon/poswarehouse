
import 'package:flutter/services.dart';
import 'package:poswarehouse/models/printer.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class PrinterService {
  const PrinterService();

  Future<void> print(Printer printer) async{
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);

    //Uint8List byte = await _getImageFromAsset('assets/images/asha.jpg');
    // await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    // await SunmiPrinter.printImage(byte);

    await SunmiPrinter.printText('', style: SunmiStyle(fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('บริษัทอาชาเทค คอเปอเรชั่น จำกัด', style: SunmiStyle(fontSize: SunmiFontSize.MD));
    await SunmiPrinter.printText('64/99 ถนนกาญจนาภิเษก แขวงดอกไม้ เขตประเวศ กรุงเทพมหานคร 10250 โทร 0959405526', style: SunmiStyle(fontSize: SunmiFontSize.MD, align: SunmiPrintAlign.CENTER));
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Name', width: 5, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: printer.name!, width: 25, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Date', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: printer.date!, width: 10, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: printer.time!, width: 10, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: '1', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: 'TopUp', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.qty}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'SUBTOTAL', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.total}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'VAT', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '0.00', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'TOTAL', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '${printer.balance}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
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