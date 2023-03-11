import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/pickupProduct/detailPickProducts.dart';
import 'package:poswarehouse/widgets/productDialog.dart';

class CeatePickupOrderPage extends StatefulWidget {
  CeatePickupOrderPage({Key? key}) : super(key: key);

  @override
  State<CeatePickupOrderPage> createState() => _CeatePickupOrderPageState();
}

class _CeatePickupOrderPageState extends State<CeatePickupOrderPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ProductDialog(
                              title: '',
                              description: '',
                              press: () {
                                Navigator.pop(context);
                              },
                              pressSelect: (){
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
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
                                  SizedBox(
                                      width: size.width * 0.08,
                                      height: size.height * 0.05,
                                      child: appTextFormField(
                                        sufPress: () {},
                                        readOnly: false,
                                        vertical: 0.0,
                                        horizontal: 0.0,
                                      )),
                                ),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPickProducts()));
                                        },
                                        icon: Icon(
                                            Icons.remove_red_eye_outlined)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {});
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
                        setState(() {});
                      },
                      child: Container(
                        width: size.width * 0.2,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'ชำระเงิน',
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
  }
}
