import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';

class DetailPickProducts extends StatefulWidget {
  DetailPickProducts({Key? key}) : super(key: key);

  @override
  State<DetailPickProducts> createState() => _DetailPickProductsState();
}

class _DetailPickProductsState extends State<DetailPickProducts> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการเบิกสินค้า'),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "สถานะ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                          child: appTextFormField(
                            sufPress: () {},
                            readOnly: false,
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'โอนจาก',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            readOnly: false,
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            readOnly: false,
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ไปยัง',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            readOnly: false,
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: double.infinity,
                child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('รหัส'),
                      ),
                      DataColumn(
                        label: Text('ชื่อสินค้า'),
                      ),
                      DataColumn(
                        label: Text('ราคาทุน'),
                      ),
                      DataColumn(
                        label: Text('จำนวน'),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        pickupOrder.length,
                        (index) => DataRow(
                              color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                // All rows will have the same selected color.
                                if (states.contains(MaterialState.selected)) {
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
                                DataCell(Text('${pickupOrder[index]['id']}')),
                                DataCell(Text('${pickupOrder[index]['poid']}')),
                                DataCell(Text('${pickupOrder[index]['name']}')),
                                DataCell(
                                    Text('${pickupOrder[index]['price']}')),
                                DataCell(
                                    Text('${pickupOrder[index]['amount']}')),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.more_vert)),
                                  ],
                                ))
                              ],
                              selected: selected[index],
                              onSelectChanged: (bool? value) {
                                setState(() {
                                  selected[index] = value!;
                                });
                              },
                            ))),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
