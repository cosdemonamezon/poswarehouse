import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/createOrderOffline.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/screen/saleItems/detailSaleItem.dart';
import 'package:provider/provider.dart';

import '../../widgets/LoadingDialog.dart';

class SaleItemsPage extends StatefulWidget {
  SaleItemsPage({Key? key}) : super(key: key);

  @override
  State<SaleItemsPage> createState() => _SaleItemsPageState();
}

class _SaleItemsPageState extends State<SaleItemsPage> {
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
    await context.read<PickupProductController>().getListOrders();
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('รายการขาย'),
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
                          onChanged: (p0) {
                            final suggestion = controller.allReceiving!.data!.where((product) {
                              final productTitle = product.stock_pick_out_no!.toLowerCase();
                              final input = p0!.toLowerCase();

                              return productTitle.contains(input);
                            }).toList();

                            setState(() => controller.allReceiving!.data = suggestion);
                          },
                          preIcon: Icons.search,
                          vertical: 25.0,
                          horizontal: 10.0,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateOrderOffLine()));
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'สร้างรายการขาย',
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
                controller.orders != null
                    ? SizedBox(
                        width: double.infinity,
                        child: controller.orders!.data!.isNotEmpty
                            ? DataTable(
                                columns: <DataColumn>[
                                    DataColumn(
                                      label: Text('#'),
                                    ),
                                    DataColumn(
                                      label: Text('รหัส'),
                                    ),
                                    DataColumn(
                                      label: Text('วันที่'),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.orders!.data!.length,
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
                                            DataCell(Text('${controller.orders!.data![index].id}')),
                                            DataCell(
                                                Text('${controller.orders!.data![index].order_no}')),
                                            DataCell(Text('${controller.orders!.data![index].created_at}')),
                                            DataCell(IconButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => DetailSaleItem()));
                                                },
                                                icon: Icon(Icons.more_vert)))
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
        ),
      );
    });
  }
}
