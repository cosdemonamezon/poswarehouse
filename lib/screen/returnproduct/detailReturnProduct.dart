import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:provider/provider.dart';

import '../../widgets/LoadingDialog.dart';
import '../pickupProduct/services/pickupProductController.dart';

class DetailReturnProduct extends StatefulWidget {
  DetailReturnProduct({Key? key, required this.stock_purchase_no}) : super(key: key);
  String stock_purchase_no;

  @override
  State<DetailReturnProduct> createState() => _DetailReturnProductState();
}

class _DetailReturnProductState extends State<DetailReturnProduct> {
  final GlobalKey<FormState> returnProductFormKey = GlobalKey<FormState>();
  final TextEditingController returnProductId = TextEditingController();
  final TextEditingController returnProductDate = TextEditingController();
  final TextEditingController returnProductName = TextEditingController();
  final TextEditingController returnProductAddress = TextEditingController();
  final TextEditingController returnProductTel = TextEditingController();
  final TextEditingController returnProductSend = TextEditingController();
  int start = 0;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Map<String, dynamic>> itemcell = [
    {"id": "1", "pid": "P001", "name": "เครื่องที่ 1", "amount": "11", "priceorigin": "200", "sum": "200"},
    {"id": "2", "pid": "P002", "name": "เครื่องที่ 2", "amount": "21", "priceorigin": "200", "sum": "200"},
    {"id": "3", "pid": "P003", "name": "เครื่องที่ 3", "amount": "41", "priceorigin": "200", "sum": "200"},
    {"id": "4", "pid": "P004", "name": "เครื่องที่ 4", "amount": "50", "priceorigin": "200", "sum": "200"}
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<PickupProductController>().getDetailReturnProduct(widget.stock_purchase_no);
    returnProductId.text = await context.read<PickupProductController>().returnProduct!.stock_purchase_no!;
    returnProductDate.text = await context.read<PickupProductController>().returnProduct!.purchase_date!;
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดคืนสินค้า'),
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
                        Icon(
                          Icons.shopify,
                          size: 35,
                        ),
                        Text(
                          'ข้อมูล',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        )
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
                          backgroundColor: Colors.green,
                          label: Text('สำเร็จ'),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
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
                              child: appTextFormField(
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
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
                                controller: returnProductName,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
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
                                controller: returnProductTel,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                        ],
                      ),
                    ),

                    ///---------------------------
                    Container(
                      child: Column(
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
                              child: appTextFormField(
                                controller: returnProductDate,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
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
                                controller: returnProductAddress,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              'ช่องทางจัดส่ง',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height: size.height * 0.06,
                              width: size.width * 0.45,
                              child: appTextFormField(
                                controller: returnProductSend,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(
                      Icons.shopify,
                      size: 35,
                    ),
                    Text(
                      'สินค้า',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: double.infinity,
                  child: controller.returnProduct?.orders?.isNotEmpty ?? false
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
                                label: Text('ราคา'),
                              ),
                              DataColumn(
                                label: Text('จำนวน'),
                              ),
                              DataColumn(
                                label: Text(''),
                              ),
                            ],
                          rows: List<DataRow>.generate(
                              controller.returnProduct!.orders!.length,
                              (index) => DataRow(
                                    color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                      // All rows will have the same selected color.
                                      if (states.contains(MaterialState.selected)) {
                                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                      }
                                      // Even rows will have a grey color.
                                      if (index.isEven) {
                                        return Colors.grey.withOpacity(0.3);
                                      }
                                      return null; // Use default value for other states and odd rows.
                                    }),
                                    cells: <DataCell>[
                                      DataCell(Text('${controller.returnProduct!.orders![index].id}')),
                                      DataCell(Text('${controller.returnProduct!.orders![index].stock_purchase_no}')),
                                      DataCell(Text('${controller.returnProduct!.orders![index].product_id}')),
                                      DataCell(Text('${controller.returnProduct!.orders![index].price}')),
                                      DataCell(Text('${controller.returnProduct!.orders![index].qty}')),
                                      DataCell(Row(
                                        children: [
                                          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                                        ],
                                      ))
                                    ],
                                    // selected: selected[index],
                                    // onSelectChanged: (bool? value) {
                                    //   setState(() {
                                    //     selected[index] = value!;
                                    //   });
                                    // },
                                  )))
                      : SizedBox.shrink(),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                                '40',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'รวม',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '3,960',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ภาษีมูลค่าเพิ่ม',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '277.2',
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
                                '2118.6',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
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
                  height: size.height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
