import 'package:flutter/material.dart';
import 'package:poswarehouse/models/client.dart';
import 'package:poswarehouse/models/confirmorder.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/orderline.dart';
import 'package:poswarehouse/models/printer.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/screen/printer/printerService.dart';
import 'package:poswarehouse/screen/printer/printerService2.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class DetailSaleItem extends StatefulWidget {
  DetailSaleItem({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<DetailSaleItem> createState() => _DetailSaleItemState();
}

class _DetailSaleItemState extends State<DetailSaleItem> {
  List<Orderline> orderline = [];
  int vat = 0;
  Printer? printer;
  bool printBinded = false;
  ConfirmOrder? confirmOrder;
  Client? client;
  int change = 0;
  List<Order>? ordersList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
    //_printerInitail();
  }

  int newQty(List<Orderline> orders) => orders.fold(0, (previousValue, e) => previousValue + int.parse(e.qty!));
  double sum(List<Orderline> orders) => orders.fold(0,
      (previous, o) => previous + (int.parse(o.qty!) * int.parse(o.price_per_unit.toString())));
  double sumcol(Orderline order) => int.parse(order.qty.toString()) * double.parse(order.price_per_unit.toString());
  double sumVat(List<Orderline> orders) => double.parse((sum(orders) * (vat / 100)).toStringAsFixed(2));
  double newtotal(List<Orderline> orders) => sum(orders) + sumVat(orders);

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<PickupProductController>().getDetailOrders(widget.id);
    setState(() {
      //ordersList = [context.read<PickupProductController>().order!];
      //final qtynew = newQty(context.read<PickupProductController>().order!.order_lines!);
      //ordersList![0].qty = qtynew.toString();
      //change = int.parse(context.read<PickupProductController>().order!.amount.toString()) - int.parse(context.read<PickupProductController>().order!.selling_price.toString());
      orderline = context.read<PickupProductController>().order!.order_lines!;
      // confirmOrder = ConfirmOrder(
      //   1,
      //   context.read<PickupProductController>().order!.order_no,
      //   context.read<PickupProductController>().order!.client_id,
      //   '',
      //   context.read<PickupProductController>().order!.type,
      //   context.read<PickupProductController>().order!.status,
      //   context.read<PickupProductController>().order!.payment,
      //   context.read<PickupProductController>().order!.amount,
      //   context.read<PickupProductController>().order!.selling_price,
      //   '',
      //   '',
      //   change,
      //   client,
      //   ordersList
      // );
      //printer = Printer(confirmOrder);
    });
    LoadingDialog.close(context);
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  void _printerInitail() {
    _bindingPrinter().then((bool? isBind) async {
      // final size = await SunmiPrinter.paperSize();
      // final version = await SunmiPrinter.printerVersion();
      // final serial = await SunmiPrinter.serialNumber();
      final printer = await SunmiPrinter.getPrinterStatus();

      setState(() {
        printBinded = isBind!;
        // serialNumber = serial;
        // printerVersion = version;
        // paperSize = size;
      });
      if (printer != PrinterStatus.NORMAL) {
        _printerInitail();
      }
      print('printBinded : $printBinded');
      // print('serialNumber : $serialNumber');
      // print('printerVersion : $printerVersion');
      // print('paperSize : $paperSize');
      print('printer : $printer');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดรายการขาย'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: controller.order != null
                ? Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.list_alt_rounded,
                                size: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "ข้อมูล",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          // IconButton(onPressed: () async{
                          //   if (printer != null) {
                          //     //await PrinterService2().print(printer!);
                          //   }                            
                          // }, icon: Icon(Icons.print_rounded, size: 35,))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  'รหัส',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.45,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Color.fromARGB(255, 227, 237, 241), border: Border.all(color: Colors.white)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          '${controller.order!.order_no}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //------------------
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  'วันที่',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.45,
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Color.fromARGB(255, 227, 237, 241), border: Border.all(color: Colors.white)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          '${controller.order!.created_at!}',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(Icons.shopify_sharp),
                          Text(
                            "สินค้า",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      controller.order != null
                          ? Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              width: double.infinity,
                              child: controller.order!.order_lines!.isNotEmpty
                                  ? DataTable(
                                      columns: <DataColumn>[
                                          DataColumn(
                                            label: Text('#'),
                                          ),
                                          DataColumn(
                                            label: Text('รหัส'),
                                          ),
                                          DataColumn(
                                            label: Text('รหัสสินค้า'),
                                          ),
                                          DataColumn(
                                            label: Text('ชื่อสินค้า'),
                                          ),
                                          DataColumn(
                                            label: SizedBox(width: size.width*0.04,child: Text('จำนวน')),
                                          ),
                                          DataColumn(
                                            label: SizedBox(width: size.width*0.10,child: Center(child: Text('ราคาขายต่อหน่วย'))),
                                          ),
                                          DataColumn(
                                            label: Text('ยอดรวม'),
                                          ),
                                        ],
                                      rows: List<DataRow>.generate(
                                          controller.order!.order_lines!.length,
                                          (index) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text('${controller.order!.order_lines![index].id}')),
                                                  DataCell(Text('${controller.order!.order_lines![index].order_no}')),
                                                  DataCell(Text('${controller.order!.order_lines![index].product!.code}')),
                                                  DataCell(Text('${controller.order!.order_lines![index].product!.name}')),
                                                  DataCell(SizedBox(width: size.width*0.04,child: Center(child: Text('${controller.order!.order_lines![index].qty}')))),
                                                  DataCell(SizedBox(width: size.width*0.10,child: Center(child: Text('${controller.order!.order_lines![index].price_per_unit}')))),
                                                  DataCell(Text('${sumcol(controller.order!.order_lines![index])}')),
                                                ],
                                              )))
                                  : SizedBox(),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFFF3F3F3),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Container(
                                width: size.width * 0.32,
                                //color: Colors.red,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'จำนวนทั้งหมด',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${newQty(orderline)}',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ราคารวม',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${sum(orderline)}',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'รวมทั้งหมด',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${newtotal(orderline)}',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ),
      );
    });
  }
}
