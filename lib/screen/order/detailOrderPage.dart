import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/damageds.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/inputTextDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../models/purchaseorders.dart';

class DetailOrderPage extends StatefulWidget {
  DetailOrderPage({Key? key, required this.stock_purchase_no}) : super(key: key);
  final String stock_purchase_no;

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final TextEditingController orderId = TextEditingController();
  final TextEditingController orderDate = TextEditingController();

  PurchaseOrders? purchaseOrder;

  final int vat = 7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<OrdersController>().getDetailPurchase(widget.stock_purchase_no);
    if (!mounted) return;

    LoadingDialog.close(context);

    setState(() {
      purchaseOrder = context.read<OrdersController>().purchaseOrders;
    });
  }

  @override
  void dispose() {
    super.dispose();
    orderId.dispose();
    orderDate.dispose();
  }

  double sum(List<Order> orders) => orders.fold(0, (previous, o) => previous + (int.parse(o.qty!) * double.parse(o.price!)));
  //double sumVat(List<Order> orders) => double.parse((sum(orders) * (vat / 100)).toStringAsFixed(2));
  //double total(List<Order> orders) => sum(orders) + sumVat(orders);
  double total(List<Order> orders) => sum(orders);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดคำสั่งซื้อ'),
      ),
      body: Consumer<OrdersController>(builder: (context, controller, child) {
        return purchaseOrder != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.list_alt_rounded),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Text(
                                "ข้อมูล",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "สถานะ",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                                ),
                              ),
                              Chip(
                                labelPadding: EdgeInsets.all(2.0),
                                elevation: 6.0,
                                shadowColor: Colors.grey[60],
                                backgroundColor: purchaseOrder?.status == 'Receive' ? Colors.green : Colors.orangeAccent,
                                label: Text('${purchaseOrder?.status}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
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
                                  'รหัสคำสั่งซื้อ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                  height: size.height * 0.06,
                                  width: size.width * 0.45,
                                  child: appTextFormField(
                                    initialValue: purchaseOrder?.stock_purchase_no,
                                    sufPress: () {},
                                    readOnly: true,
                                    vertical: 25.0,
                                    horizontal: 10.0,
                                  )),
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
                                  'วันที่รับ',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                  height: size.height * 0.06,
                                  width: size.width * 0.45,
                                  child: appTextFormField(
                                    initialValue: purchaseOrder?.purchase_date,
                                    sufPress: () {},
                                    readOnly: true,
                                    vertical: 25.0,
                                    horizontal: 10.0,
                                  )),
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
                      purchaseOrder != null
                          ? Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              width: double.infinity,
                              child: purchaseOrder!.orders!.isNotEmpty
                                  ? DataTable(
                                      dataRowHeight: size.height * 0.08,
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            '#',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'รหัส PO',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'รหัสสินค้า',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'จำนวน',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'ราคา',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: size.width * 0.15,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'หมายเหตุ',
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          purchaseOrder!.orders!.length,
                                          (index) => DataRow(
                                                selected: purchaseOrder!.orders![index].selected ?? false,
                                                onSelectChanged: (value) {
                                                  setState(() {
                                                    purchaseOrder!.orders![index].selected = value;
                                                  });
                                                },
                                                cells: <DataCell>[
                                                  DataCell(Text('${purchaseOrder!.orders![index].id}')),
                                                  DataCell(Text('${purchaseOrder!.orders![index].stock_purchase_no}')),
                                                  DataCell(Text('${purchaseOrder!.orders![index].product!.code}')),
                                                  DataCell(Text('${purchaseOrder!.orders![index].qty}')),
                                                  DataCell(Text('${purchaseOrder!.orders![index].price}')),
                                                  DataCell(
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            final selectText = await showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext context) => InputTextDialog(),
                                                            );
                                                            if (selectText != null && selectText != '') {
                                                              setState(() {
                                                                purchaseOrder!.orders![index].remark = selectText;
                                                              });
                                                            } else {}
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                            width: size.width * 0.25,
                                                            height: size.height * 0.07,
                                                            child: Center(
                                                              child: Text(purchaseOrder!.orders![index].remark ?? ''
                                                                  // '${damageds![index].remark}')
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )))
                                  : SizedBox(),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Divider(),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: size.width * 0.32,
                            //color: Colors.red,
                            child: Column(
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
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'จำนวนทั้งหมด',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '${purchaseOrder!.orders!.fold(0, (previousValue, e) => previousValue + int.parse(e.qty!))}',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'ราคารวม',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '${sum(purchaseOrder!.orders!)}',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //     children: [
                                        //       Text(
                                        //         'ภาษีมูลค่าเพิ่ม $vat%',
                                        //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        //       ),
                                        //       Text(
                                        //         '${sumVat(purchaseOrder!.orders!)}',
                                        //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 245, 250, 255),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'รวมทั้งหมด',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  '${total(purchaseOrder!.orders!)}',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                purchaseOrder?.status != 'Receive'
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Container(
                                                width: size.width * 0.1,
                                                height: size.height * 0.06,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    'ไม่อนุมัติ',
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final damageds = purchaseOrder?.orders
                                                    ?.where((o) => o.selected ?? false)
                                                    .toList()
                                                    .map((e) => Damageds(e.id, e.remark))
                                                    .toList();

                                                LoadingDialog.open(context);
                                                try {
                                                  await context
                                                      .read<OrdersController>()
                                                      .pickupNewOrders(purchaseOrder!.stock_purchase_no!, damageds!);
                                                  if (!mounted) return;
                                                  LoadingDialog.close(context);

                                                  await showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialogYes(
                                                        title: 'รับสินค้าสำเร็จ',
                                                        description: '',
                                                        pressYes: () {
                                                          Navigator.pop(context, true);
                                                        },
                                                      );
                                                    },
                                                  );
                                                  if (!mounted) return;

                                                  await context.read<OrdersController>().getListOrders();
                                                  if (!mounted) return;

                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  LoadingDialog.close(context);
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialogYes(
                                                        title: 'แจ้งเตือน',
                                                        description: e.toString(),
                                                        pressYes: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: size.width * 0.1,
                                                height: size.height * 0.06,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                                child: Center(
                                                  child: Text(
                                                    'อนุมัติ',
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink();
      }),
    );
  }
}
