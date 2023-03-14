
import 'package:flutter/material.dart';
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
      ColumnMaker(text: printer.confirmOrder!.client!.name!.toString(), width: 25, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Date', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: printer.confirmOrder!.order_date!, width: 10, align: SunmiPrintAlign.RIGHT),
      //ColumnMaker(text: printer.time!, width: 10, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Product Code:', width: 13, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 7, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.confirmOrder!.order_no}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Type:', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.confirmOrder!.type}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    // for (var i = 0; i < printer.confirmOrder!.orders!.length; i++) {
    //   await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(text: '$i', width: 10, align: SunmiPrintAlign.LEFT),
    //   ColumnMaker(text: '${printer.confirmOrder!.orders![i].product!.name}', width: 10, align: SunmiPrintAlign.LEFT),
    //   ColumnMaker(text: '${printer.confirmOrder!.orders![i].qty}', width: 10, align: SunmiPrintAlign.RIGHT),
    // ]);
    
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Price', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.confirmOrder!.selling_price}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Pay', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '${printer.confirmOrder!.amount}', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'VAT', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '0.00', width: 10, align: SunmiPrintAlign.RIGHT),
    ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Totle', width: 10, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '', width: 10, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '${printer.confirmOrder!.amount}', width: 10, align: SunmiPrintAlign.RIGHT),
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