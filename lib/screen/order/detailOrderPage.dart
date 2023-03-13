import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
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
  final TextEditingController ordername = TextEditingController();
  final TextEditingController orderType = TextEditingController();
  final TextEditingController orderAddress = TextEditingController();
  final TextEditingController orderTel = TextEditingController();
  final TextEditingController orderDate = TextEditingController();
  final TextEditingController orderTypeProduct = TextEditingController();
  final TextEditingController orderStock = TextEditingController();
  List<int> amounts = [];
  List<int> prices = [];
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
    orderDate.text = await context.read<OrdersController>().purchaseOrders!.purchase_date!;
    setState(() {
      for (var i = 0; i < context.read<OrdersController>().purchaseOrders!.orders!.length; i++) {
        amounts.add(int.parse(context.read<OrdersController>().purchaseOrders!.orders![i].qty.toString()));
        prices.add(int.parse(context.read<OrdersController>().purchaseOrders!.orders![i].price.toString()));
      }
      amount = amounts.sum;
      price = prices.sum;
      sum = amount * price;
    });

    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<OrdersController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดคำสั่งซื้อ'),
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
                            'รหัสคำสั่งซื้อ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderId,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ประเภท',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderType,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'เบอร์โทร',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderTel,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ประเภทสินค้า',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderTypeProduct,
                              sufPress: () {},
                              readOnly: false,
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
                            'ชื่อร้านค้า',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: ordername,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ที่อยู่',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderAddress,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
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
                              controller: orderDate,
                              sufPress: () {},
                              readOnly: false,
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'พื้นที่จัดเก็บสินค้า',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: orderStock,
                              sufPress: () {},
                              readOnly: false,
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
                                ],
                                rows: List<DataRow>.generate(
                                    controller.purchaseOrders!.orders!.length,
                                    (index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].id}')),
                                            DataCell(
                                                Text('${controller.purchaseOrders!.orders![index].stock_purchase_no}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].product_id}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].qty}')),
                                            DataCell(Text('${controller.purchaseOrders!.orders![index].price}')),
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
                                          'จำนวนทั้งหมด',
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
                                          'รวม',
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
                                          'ภาษีมูลค่าเพิ่ม',
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
                                            'รวมทั้งหมด',
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
                                    setState(() {});
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
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
                                    height: size.height * 0.06,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                    child: Center(
                                      child: Text(
                                        'อนุมัติ',
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
