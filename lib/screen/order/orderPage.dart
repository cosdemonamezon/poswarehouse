import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/createOrderOffline.dart';
import 'package:poswarehouse/screen/order/createOrderProductPage.dart';
import 'package:poswarehouse/screen/order/detailOrderPage.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Map<String, dynamic>> itemcell = [
    {
      "id": "1",
      "ponum": "PO-02245",
      "name": "ร้าน TT Phone",
      "date": "28/2/2566",
      "status": "รออนุมัติ"
    },
    {
      "id": "2",
      "ponum": "PO-02246",
      "name": "ร้าน TT Phone",
      "date": "2/3/2566",
      "status": "ไม่อนุมัติ"
    },
    {
      "id": "3",
      "ponum": "PO-02247",
      "name": "ร้าน TT Phone",
      "date": "28/2/2566",
      "status": "อนุมัติ"
    },
    {
      "id": "4",
      "ponum": "PO-02248",
      "name": "ร้าน TT Phone",
      "date": "2/2/2566",
      "status": "ยกเลิก"
    }
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<OrdersController>().getListOrders();
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<OrdersController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('คำสั่งซื้อ'),
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
                    SizedBox(
                        width: size.width * 0.64,
                        height: size.height * 0.08,
                        child: appTextFormField(
                          sufPress: () {},
                          readOnly: false,
                          preIcon: Icons.search,
                          vertical: 25.0,
                          horizontal: 10.0,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          final go = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateOrderProductPage()));
                          if (go == true) {
                            _initialize();
                          } else {
                            print(go);
                          }
                        },
                        child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'สร้าง',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                controller.purchaseProduct != null
                ?Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: double.infinity,
                  child: controller.purchaseProduct!.data!.isNotEmpty
                  ?DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('#'),
                        ),
                        DataColumn(
                          label: Text('เลขคำสั่งซื้อ'),
                        ),
                        DataColumn(
                          label: Text('วันที่'),
                        ),
                        DataColumn(
                          label: Text('สถานะ'),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          controller.purchaseProduct!.data!.length,
                          (index) => DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.08);
                                  }
                                  if (index.isEven) {
                                    return Colors.grey.withOpacity(0.3);
                                  }
                                  return null; 
                                }),
                                cells: <DataCell>[
                                  DataCell(Text('${controller.purchaseProduct!.data![index].No}')),
                                  DataCell(Text('${controller.purchaseProduct!.data![index].stock_purchase_no}')),
                                  DataCell(Text('${controller.purchaseProduct!.data![index].purchase_date}')),
                                  DataCell(Chip(
                                      labelPadding: EdgeInsets.all(2.0),
                                      elevation: 6.0,
                                      shadowColor: Colors.grey[60],
                                      backgroundColor: controller.purchaseProduct!.data![index].status ==
                                              'Ordered'
                                          ? Colors.orange
                                              : controller.purchaseProduct!.data![index].status ==
                                                      'Receive'
                                                  ? Colors.green
                                                  : Colors.red,
                                      label: Text(
                                          '${controller.purchaseProduct!.data![index].status}'))),
                                  DataCell(Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailOrderPage()));
                                          },
                                          icon: Icon(
                                              Icons.remove_red_eye_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.edit_calendar_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete)),
                                      IconButton(
                                          onPressed: () async{
                                            if (controller.purchaseProduct!.data![index].status != 'Receive') 
                                            {
                                              LoadingDialog.open(context);
                                              await context.read<OrdersController>().pickupNewOrders('${controller.purchaseProduct!.data![index].stock_purchase_no}');
                                              if (controller.purchase != null) {
                                                LoadingDialog.close(context);
                                                print('object Success');
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (BuildContext context) {
                                                    return AlertDialogYes(
                                                      title: 'แก้ใขสำเร็จ',
                                                      description: '',
                                                      pressYes: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                );
                                                _initialize();
                                              } else {
                                                LoadingDialog.close(context);
                                                print('object  Already Receive');
                                              }
                                              
                                            } else {
                                              print('object status = Receive');
                                            }
                                          },
                                          icon: Icon(Icons.redeem_sharp)),
                                    ],
                                  ))
                                ],
                                // selected: selected[index],
                                // onSelectChanged: (bool? value) {
                                //   setState(() {
                                //     selected[index] = value!;
                                //   });
                                // },
                              ))):SizedBox(),
                ):SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
