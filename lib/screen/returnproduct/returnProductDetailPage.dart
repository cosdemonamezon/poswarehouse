import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/widgets/appTextForm.dart';
import 'returnProductController.dart';

class ReturnProductDetailPage extends StatefulWidget {
  ReturnProductDetailPage({super.key, required this.stock_purchase_no});

  final String stock_purchase_no;

  @override
  State<ReturnProductDetailPage> createState() => _ReturnProductDetailPageState();
}

class _ReturnProductDetailPageState extends State<ReturnProductDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  Future<void> loadData() async {
    context.read<ReturnProductController>().getDetail(widget.stock_purchase_no);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดสินค้าชำรุด'),
      ),
      body: Consumer<ReturnProductController>(builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: controller.purchaseDamage != null
                ? Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                                label: Text('${controller.purchaseDamage!.status}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
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
                                  'รหัส',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                  height: size.height * 0.06,
                                  width: size.width * 0.45,
                                  child: appTextFormField(
                                    sufPress: () {},
                                    initialValue: controller.purchaseDamage?.stock_purchase_no,
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
                                  'วันที่',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                  height: size.height * 0.06,
                                  width: size.width * 0.45,
                                  child: appTextFormField(
                                    sufPress: () {},
                                    initialValue: controller.purchaseDamage?.purchase_date,
                                    readOnly: true,
                                    vertical: 25.0,
                                    horizontal: 10.0,
                                  )),
                            ],
                          ),
                        ],
                      ),
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
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: controller.purchaseDamage?.orders?.isNotEmpty ?? false
                            ? DataTable(
                                columns: <DataColumn>[
                                    DataColumn(
                                      label: Text('#'),
                                    ),
                                    DataColumn(
                                      label: Text('รหัส'),
                                    ),                                    
                                    DataColumn(
                                      label: Text('จำนวน'),
                                    ),
                                    DataColumn(
                                      label: Text('ราคา'),
                                    ),
                                    DataColumn(
                                      label: Text('หมายเหตุ'),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.purchaseDamage?.orders?.length ?? 0,
                                    (index) => DataRow(
                                          color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                            
                                            if (states.contains(MaterialState.selected)) {
                                              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                            }
                                            
                                            if (index.isEven) {
                                              return Colors.grey.withOpacity(0.3);
                                            }
                                            return null; 
                                          }),
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.purchaseDamage?.orders?[index].id}')),
                                            DataCell(Text('${controller.purchaseDamage?.orders?[index].stock_purchase_no}')),                                            
                                            DataCell(Text('${controller.purchaseDamage?.orders?[index].qty}')),
                                            DataCell(Text('${controller.purchaseDamage?.orders?[index].price}')),
                                            DataCell(Text(controller.purchaseDamage?.orders?[index].remark ?? '')),
                                          ],
                                          
                                        )))
                            : SizedBox.shrink(),
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        );
      }),
    );
  }
}
