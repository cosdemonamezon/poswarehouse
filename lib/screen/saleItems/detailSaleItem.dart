import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/orderline.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class DetailSaleItem extends StatefulWidget {
  DetailSaleItem({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<DetailSaleItem> createState() => _DetailSaleItemState();
}

class _DetailSaleItemState extends State<DetailSaleItem> {
  List<Orderline> orderline = [];
  int vat = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  int newQty(List<Orderline> orders) => orders.fold(0, (previousValue, e) => previousValue + int.parse(e.qty!));
  double sum(List<Orderline> orders) => orders.fold(0, (previous, o) => previous + (int.parse(o.qty!)  * int.parse(context.read<PickupProductController>().order!.selling_price.toString())));
  double sumVat(List<Orderline> orders) => double.parse((sum(orders) * (vat / 100)).toStringAsFixed(2));
  double newtotal(List<Orderline> orders) => sum(orders) + sumVat(orders);
  

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<PickupProductController>().getDetailOrders(widget.id);
    setState(() {
      orderline = context.read<PickupProductController>().order!.order_lines!;
    });
    LoadingDialog.close(context);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<PickupProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดรายการขาย'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: controller.order != null
            ?Column(
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.print_rounded,
                            size: 40,
                          ),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 227, 237, 241),
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.order!.order_no}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 227, 237, 241),
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${controller.order!.created_at}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
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
                controller.order != null
                ?Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: double.infinity,
                  child: controller.order!.order_lines!.isNotEmpty
                  ?DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('#'),
                        ),
                        DataColumn(
                          label: Text('รหัสสินค้า'),
                        ),
                        DataColumn(
                          label: Text('ชื่อสินค้า'),
                        ),
                        DataColumn(
                          label: Text('จำนวน'),
                        ),
                        DataColumn(
                          label: Text('ราคาขาย'),
                        ),
                        DataColumn(
                          label: Text('ยอดรวม'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          controller.order!.order_lines!.length,
                          (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('${controller.order!.order_lines![index].id}')),
                                  DataCell(
                                      Text('${controller.order!.order_lines![index].order_no}')),
                                  DataCell(Text('${controller.order!.order_lines![index].product!.name}')),
                                  DataCell(
                                      Text('${controller.order!.order_lines![index].qty}')),
                                  DataCell(
                                      Text('${controller.order!.selling_price}')),
                                  DataCell(
                                      Text('${sum(orderline)}')),
                                ],
                              ))):SizedBox(),
                ):SizedBox(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'จำนวนทั้งหมด',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${newQty(orderline)}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'รวม',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${sum(orderline)}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'รวมทั้งหมด',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${newtotal(orderline)}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                              
                          //     Padding(
                          //       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          //       child: GestureDetector(
                          //         onTap: () async {
                          //           setState(() {});
                          //         },
                          //         child: Container(
                          //           width: size.width * 0.1,
                          //           height: size.height * 0.06,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //               color: kPrimaryColor),
                          //           child: Center(
                          //             child: Text(
                          //               'ชำระเงิน',
                          //               style: TextStyle(
                          //                   fontSize: 18,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.white),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
              ],
            ):SizedBox(),
          ),
        ),
      );
  });}
}
