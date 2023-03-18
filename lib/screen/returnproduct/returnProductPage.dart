import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/returnproduct/createReturnProduct.dart';
import 'package:poswarehouse/screen/returnproduct/detailReturnProduct.dart';
import 'package:poswarehouse/screen/returnproduct/returnProductController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

import 'returnProductDetailPage.dart';

class ReturnProductPage extends StatefulWidget {
  ReturnProductPage({Key? key}) : super(key: key);

  @override
  State<ReturnProductPage> createState() => _ReturnProductPageState();
}

class _ReturnProductPageState extends State<ReturnProductPage> {
  int start = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    await context.read<ReturnProductController>().initialinze();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้าชำรุด'),
      ),
      body: Consumer<ReturnProductController>(builder: (context, controller, child) {
        return SingleChildScrollView(
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
                    Expanded(
                      flex: 3,
                      child: appTextFormField(
                        sufPress: () {},
                        readOnly: false,
                        onChanged: (p0) async {
                          await context.read<ReturnProductController>().initialinze(search: p0);
                        },
                        preIcon: Icons.search,
                        vertical: 25.0,
                        horizontal: 10.0,
                      ),
                    ),
                    // Flexible(
                    //   flex: 1,
                    //   child: Padding(
                    //     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //     child: GestureDetector(
                    //       onTap: () async {
                    //         Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReturnProduct()));
                    //       },
                    //       child: Container(
                    //         width: size.width * 0.2,
                    //         height: size.height * 0.08,
                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                    //         child: Center(
                    //           child: Text(
                    //             'สร้างรายการคืนสินค้า',
                    //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                controller.purchaseDamages.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: controller.purchaseDamages.isNotEmpty
                            ? DataTable(
                                dataRowHeight: size.height * 0.08,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      '#',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'รหัส',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'หมายเหตุ',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'สถานะ',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(''),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    controller.purchaseDamages.length,
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
                                            DataCell(Text('${controller.purchaseDamages[index]}')),
                                            DataCell(Text('${controller.purchaseDamages[index].stock_purchase_no}')),
                                            DataCell(Text(controller.purchaseDamages[index].remark ?? '-')),
                                            DataCell(Chip(
                                                labelPadding: EdgeInsets.all(2.0),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                labelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                                elevation: 6.0,
                                                shadowColor: Colors.grey[60],
                                                backgroundColor:
                                                    controller.purchaseDamages[index].status == 'Finish' ? Colors.green : Colors.red[100],
                                                label: Text('${controller.purchaseDamages[index].status}'))),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ReturnProductDetailPage(
                                                                    stock_purchase_no:
                                                                        '${controller.purchaseDamages[index].stock_purchase_no}',
                                                                  )));
                                                    },
                                                    icon: Icon(Icons.remove_red_eye_outlined)),
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
                        config: NumberPaginatorUIConfig(mode: ContentDisplayMode.hidden),
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
        );
      }),
    );
  }
}
