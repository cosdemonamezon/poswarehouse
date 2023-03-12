import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/pickupProduct/createPickupOrderPage.dart';
import 'package:poswarehouse/screen/pickupProduct/detailPickProducts.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:provider/provider.dart';

import '../../widgets/LoadingDialog.dart';

class PickupProductPage extends StatefulWidget {
  PickupProductPage({Key? key}) : super(key: key);

  @override
  State<PickupProductPage> createState() => _PickupProductPageState();
}

class _PickupProductPageState extends State<PickupProductPage> {
  int start = 0;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<PickupProductController>().getListPickupProducts();
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('เบิกสินค้า'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CeatePickupOrderPage()));
                        },
                        child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เบิกสินค้า',
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
                controller.allReceiving != null
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: controller.allReceiving!.data!.isNotEmpty
                            ? DataTable(
                                dataRowHeight: size.height * 0.08,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      '#',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'รหัส',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'วันที่',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'สถานะ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(''),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    pickupproduct.length,
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
                                              return Colors.grey
                                                  .withOpacity(0.3);
                                            }
                                            return null; // Use default value for other states and odd rows.
                                          }),
                                          cells: <DataCell>[
                                            DataCell(Text(
                                                '${controller.allReceiving!.data![index].No}')),
                                            DataCell(Text(
                                                '${controller.allReceiving!.data![index].stock_purchase_no}')),
                                            DataCell(Text(
                                                '${controller.allReceiving!.data![index].purchase_date}')),
                                            DataCell(Chip(
                                                labelPadding:
                                                    EdgeInsets.all(2.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16),
                                                elevation: 6.0,
                                                shadowColor: Colors.grey[60],
                                                backgroundColor:
                                                    controller.allReceiving!.data![index].status == 'Receive'
                                                        ? Colors.green
                                                        : Colors.red,
                                                label: Text(
                                                    '${controller.allReceiving!.data![index].status}'))),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailPickProducts(stock_purchase_no: '${controller.allReceiving!.data![index].stock_purchase_no}',)));
                                                    },
                                                    icon: Icon(Icons
                                                        .remove_red_eye_outlined)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons
                                                        .edit_calendar_outlined)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ))
                                          ],
                                          selected: selected[index],
                                          onSelectChanged: (bool? value) {
                                            setState(() {
                                              selected[index] = value!;
                                            });
                                          },
                                        )))
                            : SizedBox(),
                      )
                    : SizedBox(),
                // controller.allProduct != null
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.22,
                      child: NumberPaginator(
                        // numberPages: controller.allProduct!.last_page!,
                        numberPages: 1,
                        onPageChange: (p0) async {
                          LoadingDialog.open(context);
                          setState(() {
                            start = ((p0 - 1) * start) + 10;
                            print(start);
                          });
                          // await context.read<ProductController>().getListProducts(start: start);
                          if (!mounted) {
                            return;
                          }
                          LoadingDialog.close(context);
                        },
                      ),
                    ),
                  ],
                ),
                // : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
