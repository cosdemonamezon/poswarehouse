import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

class DetailPickProducts extends StatefulWidget {
  DetailPickProducts({Key? key, required this.stock_purchase_no}) : super(key: key);
  String stock_purchase_no;
  @override
  State<DetailPickProducts> createState() => _DetailPickProductsState();
}

class _DetailPickProductsState extends State<DetailPickProducts> {
  final TextEditingController purchaseId = TextEditingController();
  final TextEditingController date = TextEditingController();
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<PickupProductController>().getDetail(widget.stock_purchase_no);
    purchaseId.text = await context.read<PickupProductController>().receivingGoods!.stock_pick_out_no!;
    date.text = await context.read<PickupProductController>().receivingGoods!.pick_out_date!;
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดการเบิกสินค้า'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: controller.receivingGoods != null
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
                                label: Text('${controller.receivingGoods!.status}'),
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
                                    controller: purchaseId,
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
                                    controller: date,
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
                        child: controller.receivingGoods!.orders!.isNotEmpty
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
                                      label: Text('จำนวน'),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.receivingGoods!.orders!.length,
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
                                            DataCell(Text('${controller.receivingGoods!.orders![index].id}')),
                                            DataCell(Text('${controller.receivingGoods!.orders![index].stock_pick_out_no}')),
                                            DataCell(Text('${controller.receivingGoods!.orders![index].product!.code}')),
                                            DataCell(Text('${controller.receivingGoods!.orders![index].qty}')),
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
                        height: size.height * 0.08,
                      ),
                      SizedBox(
                        width: size.width * 0.42,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            //   child: GestureDetector(
                            //     onTap: () async {
                            //       setState(() {});
                            //     },
                            //     child: Container(
                            //       width: size.width * 0.1,
                            //       height: size.height * 0.06,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(10),
                            //           color: Colors.white,
                            //           border: Border.all(color: Colors.grey)),
                            //       child: Center(
                            //         child: Text(
                            //           'ไม่อนุมัติ',
                            //           style: TextStyle(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            controller.receivingGoods!.status != 'Receive'
                                ? Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          LoadingDialog.open(context);
                                          await context.read<PickupProductController>().receiveStockPickout(purchaseId.text);

                                          LoadingDialog.close(context);
                                          setState(() {});
                                          Navigator.of(context)
                                            ..pop()
                                            ..pop();
                                        } on Exception catch (e) {
                                          LoadingDialog.close(context);
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialogYes(
                                                title: 'แจ้งเตือน',
                                                description: e.toString(),
                                                pressYes: () {
                                                  Navigator.pop(context, true);
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.06,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                        child: Center(
                                          child: Text(
                                            'อนุมัติ',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ),
      );
    });
  }
}
