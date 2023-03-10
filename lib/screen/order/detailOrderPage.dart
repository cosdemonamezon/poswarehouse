import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/damageds.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/inputNumberDialog.dart';
import 'package:poswarehouse/widgets/inputTextDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

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
  List<int> amounts = [];
  List<int> prices = [];
  List<Damageds>? damageds = [];
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  static const int numItems = 10;
  //Damageds? damaged;
  int amount = 0;
  int price = 0;
  int sum = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<OrdersController>().getDetailPurchase(widget.stock_purchase_no);
    orderId.text = await context.read<OrdersController>().purchaseOrders!.stock_purchase_no!;
    // orderDate.text = await context.read<OrdersController>().purchaseOrders!.purchase_date!;
    // setState(() {
    //   for (var i = 0; i < context.read<OrdersController>().purchaseOrders!.orders!.length; i++) {
    //     amounts.add(int.parse(context.read<OrdersController>().purchaseOrders!.orders![i].qty.toString()));
    //     prices.add(int.parse(context.read<OrdersController>().purchaseOrders!.orders![i].price.toString()));
    //     final damaged =
    //         new Damageds(int.parse(context.read<OrdersController>().purchaseOrders!.orders![i].id.toString()), '');

    //     damageds!.add(damaged);
    //   }
    //   amount = amounts.sum;
    //   price = prices.sum;
    //   sum = amount * price;
    // });

    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<OrdersController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('????????????????????????????????????????????????????????????'),
        ),
        body: SingleChildScrollView(
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
                        Text(
                          "??????????????????",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "???????????????",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Chip(
                          labelPadding: EdgeInsets.all(2.0),
                          elevation: 6.0,
                          shadowColor: Colors.grey[60],
                          backgroundColor:
                              controller.purchaseOrders?.status == 'Receive' ? Colors.green : Colors.orangeAccent,
                          label: Text('${controller.purchaseOrders?.status}'),
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
                            '??????????????????????????????????????????',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderId,
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
                            '???????????????????????????',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderDate,
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
                      "??????????????????",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                controller.purchaseOrders != null
                    ? Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: controller.purchaseOrders!.orders!.isNotEmpty
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
                                      '???????????? PO',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '??????????????????????????????',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '???????????????',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '????????????',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      '????????????????????????',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    controller.purchaseOrders!.orders!.length,
                                    (index) => DataRow(
                                          selected: selected[index],
                                          onSelectChanged: (value) {
                                            final damaged = Damageds(controller.purchaseOrders!.orders![index].id, '');
                                            setState(() {
                                              selected[index] = value!;
                                              controller.purchaseOrders!.orders![index].selected = value;
                                              print(controller.purchaseOrders!.orders![index].selected);
                                              if (value) {
                                                // '?????????????????????';
                                                damageds!.add(damaged);
                                                // inspect(ListChacked);
                                              }
                                            });
                                          },
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].id}')),
                                            DataCell(
                                                Text('${controller.purchaseOrders!.orders![index].stock_purchase_no}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].product_id}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].qty}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].price}')),
                                            DataCell(
                                              InkWell(
                                                onTap: () async {
                                                  final selectText = await showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => InputTextDialog(),
                                                  );
                                                  if (selectText != null && selectText != '') {
                                                    setState(() {
                                                      damageds![index].remark = selectText;
                                                    });
                                                    inspect(damageds);
                                                  } else {}
                                                },
                                                child: SizedBox(
                                                  width: size.width * 0.05,
                                                  //child: Center(child: Text('${listneworder[index].qty}')),
                                                  child: Center(
                                                      child: Text(''
                                                          // '${damageds![index].remark}'
                                                          )),
                                                ),
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
                    Container(
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
                                          '????????????????????????????????????',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${amount}',
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
                                          '?????????',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${price}',
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
                                          '?????????????????????????????????????????????',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '%',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
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
                                            '??????????????????????????????',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${sum}',
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
                          Row(
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
                                        '??????????????????????????????',
                                        style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (controller.purchaseOrders?.status != 'Receive') {
                                      LoadingDialog.open(context);
                                      await context.read<OrdersController>().pickupNewOrders(orderId.text, damageds!);
                                      if (controller.purchase != null) {
                                        LoadingDialog.close(context);
                                        print('object Success');
                                        final _alert = await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialogYes(
                                              title: '?????????????????????????????????????????????',
                                              description: '',
                                              pressYes: () {
                                                Navigator.pop(context, true);
                                              },
                                            );
                                          },
                                        );
                                        if (_alert == true) {
                                          Navigator.pop(context, true);
                                        }
                                      } else {
                                        LoadingDialog.close(context);
                                        print('object  Already Receive');
                                      }
                                    } else {
                                      print('object status = Receive');
                                    }
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.06,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                    child: Center(
                                      child: Text(
                                        '?????????????????????',
                                        style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
        ),
      );
    });
  }
}
