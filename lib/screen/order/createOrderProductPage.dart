import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/extension/dateExtension.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/unit.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/screen/pickupProduct/detailPickProducts.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/inputNumberDialog.dart';
import 'package:poswarehouse/widgets/productDialog.dart';
import 'package:poswarehouse/widgets/unitDialog.dart';
import 'package:provider/provider.dart';

class CreateOrderProductPage extends StatefulWidget {
  CreateOrderProductPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderProductPage> createState() => _CreateOrderProductPageState();
}

class _CreateOrderProductPageState extends State<CreateOrderProductPage> {
  final GlobalKey<FormState> orderFormKey = GlobalKey<FormState>();
  final TextEditingController? datePick = TextEditingController();
  List<TextEditingController>? qtyController = [];
  DateTime dateTime = DateTime.now();
  int numItems = 0;
  List<bool> selected = [];

  List<NewOrders> listneworder = [];
  NewOrders? order;
  //NewOrders emptyorder = new NewOrders('0', 0, 0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
    _unitinitialize();
    setState(() {
      datePick!.text = dateTime.formatTo('yyyy-MM-dd');
    });
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListProducts();
    LoadingDialog.close(context);
  }

  Future<void> _unitinitialize() async {
    await context.read<ProductController>().getListUnits();
  }

  Future<DateTime?> pickDate() =>
      showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(1900), lastDate: DateTime(2100));
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ProductController, OrdersController>(builder: (context, controller, ordersController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('สร้างคำสั่งซื้อ'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    'ราคาขายปลีก',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                    height: size.height * 0.08,
                    width: size.width * 0.45,
                    child: appTextFormField(
                      controller: datePick,
                      readOnly: false,
                      sufPress: () async {
                        final _pick = await pickDate();
                        setState(() {
                          datePick!.text = _pick!.formatTo('yyyy-MM-dd');
                        });
                      },
                      sufIcon: Icons.calendar_month,
                      vertical: 25.0,
                      horizontal: 10.0,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกหมายเลขโทรศัพท์';
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.shopify_outlined),
                        Text(
                          "สินค้า",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          final _select = await showDialog<List<Product>>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ProductDialog(
                                title: '',
                                description: '',
                                allProduct: controller.allProduct!.data,
                                press: () {
                                  Navigator.pop(context);
                                },
                                pressSelect: () async {},
                              );
                            },
                          );
                          if (_select != null && _select.isNotEmpty) {
                            //inspect(_select);
                            setState(() {
                              final List<NewOrders> select = _select
                                  .map((e) => NewOrders(e.id.toString(), 0, 0, int.parse(e.cost!), 15,
                                      int.parse(e.unit_id!), controller.units!.data![0], e, false))
                                  .toList();

                              listneworder.addAll(select);

                              // listneworder.add(value)

                              // selectProducts = _select;
                              // numItems = selectProducts.length;
                              // selected  = List<bool>.generate(numItems, (int index) => false);
                              // for (var i = 0; i < selectProducts.length; i++) {
                              //   //qtyController!.add(TextEditingController(text: '0'));
                              //   qtyText.add('0');
                              //   unitController!.add(TextEditingController(text: '0'));
                              //   qtyunitController!.add(TextEditingController(text: '0'));
                              //   listneworder.add(emptyorder);
                              // }
                            });
                            inspect(listneworder);
                          } else {
                            print('object Na data of Select');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เพิ่มสินค้า',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                Container(
                  width: double.infinity,
                  height: size.height * 0.40,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  //color: Colors.amber,
                  child: listneworder.isNotEmpty
                      ? SingleChildScrollView(
                          child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                              dataRowHeight: size.height * 0.10,
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text(''),
                                ),
                                DataColumn(
                                  label: Text('รหัส'),
                                ),
                                DataColumn(
                                  label: Center(child: Text('ชื่อสินค้า')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('รูปภาพ')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('ราคาขาย')),
                                ),
                                DataColumn(
                                  label: Text('จำนวน'),
                                ),
                                DataColumn(
                                  label: Text('หน่วย'),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                  listneworder.length,
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
                                          DataCell(IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  listneworder.removeAt(index);
                                                });
                                              },
                                              icon: Icon(Icons.delete))),
                                          DataCell(Text('${listneworder[index].product!.No}')),
                                          DataCell(Text('${listneworder[index].product!.name}')),
                                          DataCell(SizedBox(
                                            width: size.width * 0.05,
                                            height: size.height * 0.10,
                                            child: listneworder[index].product!.image != null
                                                ? Image.network('${listneworder[index].product!.image}',
                                                    fit: BoxFit.fill)
                                                : Image.asset(
                                                    'assets/images/noimage.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                          )),
                                          DataCell(SizedBox(
                                            width: size.width * 0.03,
                                            child: Text('${listneworder[index].product!.price_for_retail}'),
                                          )),
                                          DataCell(
                                            InkWell(
                                              onTap: () async {
                                                final selectNumber = await showDialog<String>(
                                                  context: context,
                                                  builder: (BuildContext context) => InputNumberDialog(),
                                                );
                                                if (selectNumber != null) {
                                                  setState(() {
                                                    listneworder[index].qty = int.parse(selectNumber);
                                                    // selectProducts[index]. = int.parse(selectNumber);
                                                    // qtyText.insert(index, selectNumber);
                                                    // qtyText.removeAt(index + 1);
                                                    // order = new NewOrders(selectProducts[index].id.toString(),int.parse(qtyText[index]),int.parse(selectProducts[index].price_for_retail.toString()),selectProducts[index].unit!.id);
                                                    // listneworder.insert(index, order!);
                                                    // listneworder.removeAt(index + 1);
                                                  });
                                                  inspect(listneworder);
                                                } else {}
                                              },
                                              child: Container(
                                                width: size.width * 0.05,
                                                height: size.height * 0.05,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                child: Center(child: Text('${listneworder[index].qty}')),
                                              ),
                                            ),
                                          ),
                                          DataCell(SizedBox(
                                            width: size.width * 0.06,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    final selectUnit = await showDialog<Unit>(
                                                      context: context,
                                                      builder: (BuildContext context) => UnitDialog(
                                                        units: controller.units!.data!,
                                                      ),
                                                    );
                                                    if (selectUnit != null) {
                                                      setState(() {
                                                        listneworder[index].unit_id = selectUnit.id;
                                                        listneworder[index].unit = selectUnit;
                                                      });
                                                    } else {}
                                                  },
                                                  child: Container(
                                                    width: size.width * 0.05,
                                                    height: size.height * 0.05,
                                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                    child: Center(child: Text('${listneworder[index].unit!.name}')),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ],
                                      ))),
                        ))
                      : SizedBox(
                          height: size.height * 0.40,
                        ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: Text(
                              'ยกเลิก',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.06,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          //final list = listneworder.where((element) => element.selected == true).toList();
                          //inspect(listneworder);
                          if (listneworder.isNotEmpty) {
                            await context.read<OrdersController>().createNewOrder(datePick!.text, listneworder);
                            if (ordersController.stockPurchase != null) {
                              print('object Create Success****');
                              Navigator.pop(context, true);
                            } else {
                              print('object Error Data');
                            }
                          } else {
                            print('object No Select Data');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'บันทึก',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
        ),
      );
    });
  }
}
