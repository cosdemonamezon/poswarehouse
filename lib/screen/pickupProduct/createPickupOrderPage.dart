import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/extension/dateExtension.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/productDialog.dart';
import 'package:provider/provider.dart';

class CeatePickupOrderPage extends StatefulWidget {
  CeatePickupOrderPage({Key? key}) : super(key: key);

  @override
  State<CeatePickupOrderPage> createState() => _CeatePickupOrderPageState();
}

class _CeatePickupOrderPageState extends State<CeatePickupOrderPage> {
  final TextEditingController? datePick = TextEditingController();
  List<TextEditingController>? qtyController = [];
  DateTime dateTime = DateTime.now();
  int numItems = 0;
  List<bool> selected = [];
  List<Product> selectProducts = [];

  List<NewOrders> listneworder = [];
  NewOrders? order;
  NewOrders emptyorder = new NewOrders('0', 0, 0, 0);
  //List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
    setState(() {
      datePick!.text = dateTime.formatTo('yyyy-MM-dd');
    });
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListProducts();
    LoadingDialog.close(context);
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ProductController, PickupProductController>(
        builder: (context, controller, pickupController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('สร้างรายการเบิกสินค้า'),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ราคาขายปลีก',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                                  datePick!.text =
                                      _pick!.formatTo('yyyy-MM-dd');
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
                      ],
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.symmetric(vertical: 2),
                //           child: Text(
                //             'รหัส',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16),
                //           ),
                //         ),
                //         SizedBox(
                //             height: size.height * 0.06,
                //             width: size.width * 0.45,
                //             child: appTextFormField(
                //               sufPress: () {},
                //               readOnly: false,
                //               vertical: 25.0,
                //               horizontal: 10.0,
                //             )),
                //         Padding(
                //           padding: EdgeInsets.symmetric(vertical: 2),
                //           child: Text(
                //             'โอนจาก',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16),
                //           ),
                //         ),
                //         SizedBox(
                //             height: size.height * 0.06,
                //             width: size.width * 0.45,
                //             child: appTextFormField(
                //               sufPress: () {},
                //               readOnly: false,
                //               vertical: 25.0,
                //               horizontal: 10.0,
                //             )),
                //       ],
                //     ),
                //     //------------------
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.symmetric(vertical: 2),
                //           child: Text(
                //             'วันที่',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16),
                //           ),
                //         ),
                //         SizedBox(
                //             height: size.height * 0.06,
                //             width: size.width * 0.45,
                //             child: appTextFormField(
                //               sufPress: () {},
                //               readOnly: false,
                //               vertical: 25.0,
                //               horizontal: 10.0,
                //             )),
                //         Padding(
                //           padding: EdgeInsets.symmetric(vertical: 2),
                //           child: Text(
                //             'ไปยัง',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.bold, fontSize: 16),
                //           ),
                //         ),
                //         SizedBox(
                //             height: size.height * 0.06,
                //             width: size.width * 0.45,
                //             child: appTextFormField(
                //               sufPress: () {},
                //               readOnly: false,
                //               vertical: 25.0,
                //               horizontal: 10.0,
                //             )),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopify_sharp),
                        Text(
                          "สินค้า",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          final _select = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ProductDialog(
                                title: '',
                                description: '',
                                allProduct: controller.allProduct,
                                selectProducts: selectProducts,
                                press: () {
                                  Navigator.pop(context);
                                },
                                pressSelect: () async {},
                              );
                            },
                          );
                          if (_select.isNotEmpty) {
                            //inspect(_select);
                            setState(() {
                              selectProducts = _select;
                              numItems = selectProducts.length;
                              selected  = List<bool>.generate(numItems, (int index) => false);
                              for (var i = 0; i < selectProducts.length; i++) {
                                qtyController!.add(TextEditingController(text: '0'));
                                listneworder.add(emptyorder);
                              }
                              
                            });
                            inspect(selectProducts);
                          } else {
                            print('object Na data of Select');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เพิ่มสินค้า',
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
                  height: size.height * 0.03,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.40,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  //color: Colors.amber,
                  child: selectProducts.isNotEmpty
                      ? SingleChildScrollView(
                          child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                              columns: <DataColumn>[
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
                                  label: Center(child: Text('ราคาขายส่ง')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('จำนวน')),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                  selectProducts.length,
                                  (index) => DataRow(
                                        color: MaterialStateProperty
                                            .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                          // All rows will have the same selected color.
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.08);
                                          }
                                          // Even rows will have a grey color.
                                          if (index.isEven) {
                                            return Colors.grey.withOpacity(0.3);
                                          }
                                          return null; // Use default value for other states and odd rows.
                                        }),
                                        cells: <DataCell>[
                                          DataCell(Text(
                                              '${selectProducts[index].No}')),
                                          DataCell(Text(
                                              '${selectProducts[index].name}')),
                                          DataCell(SizedBox(
                                            width: size.width * 0.05,
                                            height: size.height * 0.10,
                                            child: selectProducts[index]
                                                        .image !=
                                                    null
                                                ? Image.network(
                                                    '${selectProducts[index].image}',
                                                    fit: BoxFit.fill)
                                                : Image.asset(
                                                    'assets/images/noimage.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                          )),
                                          
                                          DataCell(SizedBox(
                                            width: size.width * 0.03,
                                            child: Text(
                                                '${selectProducts[index].price_for_retail}'),
                                          )),
                                          DataCell(
                                            Center(
                                              child: SizedBox(
                                                  height: size.height * 0.045,
                                                  child: appTextFormField(
                                                    controller: qtyController![index],
                                                    readOnly: selected[index] ? false : true,
                                                    sufPress: () async {},
                                                    onChanged: (newValue) async{
                                                      //print(newValue);
                                                      setState(() {
                                                        if (newValue == "") {
                                                          qtyController![index].text = '';
                                                          order = new NewOrders(selectProducts[index].id.toString(),0,int.parse(selectProducts[index].price_for_retail.toString()),selectProducts[index].unit!.id);                                                        
                                                          listneworder.insert(index, order!);
                                                          listneworder.removeAt(index + 1);
                                                        } else {
                                                          qtyController![index].text = newValue.toString();
                                                          order = new NewOrders(selectProducts[index].id.toString(),int.parse(qtyController![index].text),int.parse(selectProducts[index].price_for_retail.toString()),selectProducts[index].unit!.id);                                                        
                                                          listneworder.insert(index, order!);
                                                          listneworder.removeAt(index + 1);
                                                        }
                                                        
                                                      });
                                                      inspect(listneworder);
                                                    },
                                                    vertical: 0.0,
                                                    horizontal: 0.0,
                                                    color: Color.fromARGB(255, 245, 245, 245),
                                                  )),
                                            ),
                                          ),
                                        ],
                                        selected: selected[index],
                                        onSelectChanged: (bool? value) {
                                          setState(() {
                                            selected[index] = value!;
                                            if (qtyController!.isNotEmpty) {
                                              if (selected[index] == true) {
                                                order = new NewOrders(selectProducts[index].id.toString(),int.parse(qtyController![index].text),int.parse(selectProducts[index].price_for_retail.toString()),selectProducts[index].unit!.id);
                                                //listneworder.add(order!); 
                                                listneworder.insert(index, order!);
                                                listneworder.removeAt(index + 1);
                                              } else {
                                                //print(selectProducts[index].No);
                                                listneworder.removeAt(index);
                                                listneworder.insert(index, emptyorder);
                                                //listneworder.clear();
                                              }   
                                              inspect(listneworder);
                                            }else {
                                              print('object No add QTY');
                                              listneworder.clear();
                                            }
                                          });
                                        },
                                      ))),
                        ))
                      : SizedBox(
                          height: size.height * 0.40,
                        ),
                ),
                SizedBox(
                  height: size.height * 0.08,
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
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                          setState(() {
                            final list = listneworder.where((element) => element.product_id != '0').toList();
                            listneworder.clear();
                            listneworder = list;
                          });
                          //inspect(listneworder);
                          if (listneworder.isNotEmpty) {
                            await context.read<PickupProductController>().createNewOrder(datePick!.text, listneworder);
                            if (pickupController.stockPurchase != null) {
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'บันทึก',
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
