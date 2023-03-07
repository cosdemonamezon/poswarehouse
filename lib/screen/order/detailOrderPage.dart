import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';

class DetailOrderPage extends StatefulWidget {
  DetailOrderPage({Key? key}) : super(key: key);

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดคำสั่งซื้อ'),
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
                  Row(
                    children: [
                      Icon(Icons.list_alt_rounded),
                      Text(
                        "ข้อมูล",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
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
                        backgroundColor: Colors.orangeAccent,
                        label: Text('รออนุมัติ'),
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
                          'รหัสคำสั่งซื้อ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ประเภท',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'เบอร์โทร',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ประเภทสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
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
                          'ชื่อร้านค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ที่อยู่',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'วันที่รับ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'พื้นที่จัดเก็บสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.45,
                          child: appTextFormField(
                            sufPress: () {},
                            vertical: 25.0,
                            horizontal: 10.0,
                          )),
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
                        label: Text('รหัสสินค้า'),
                      ),
                      DataColumn(
                        label: Text('ชื่อสินค้า'),
                      ),
                      DataColumn(
                        label: Text('จำนวน'),
                      ),
                      DataColumn(
                        label: Text('ราคาทุน'),
                      ),
                      DataColumn(
                        label: Text('ยอดรวม'),
                      ),
                      DataColumn(
                        label: Text('ประเภท'),
                      ),
                      DataColumn(
                        label: Text('ที่เก็บสินค้า'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        newitemcell.length,
                        (index) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text('${newitemcell[index]['id']}')),
                                DataCell(
                                    Text('${newitemcell[index]['itemcode']}')),
                                DataCell(Text('${newitemcell[index]['name']}')),
                                DataCell(
                                    Text('${newitemcell[index]['amount']}')),
                                DataCell(
                                    Text('${newitemcell[index]['price']}')),
                                DataCell(
                                    Text('${newitemcell[index]['total']}')),
                                DataCell(
                                    Text('${newitemcell[index]['type']}')),
                                DataCell(Text(
                                    '${newitemcell[index]['warehouseID']}')),
                              ],
                            ))),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Divider(),
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
                        Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xFFF3F3F3),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'จำนวนทั้งหมด',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '40',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'รวม',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '3,960',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ภาษีมูลค่าเพิ่ม',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '277.2',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 250, 255),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'รวมทั้งหมด',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '2118.6',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: Container(
                                  width: size.width * 0.1,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text(
                                      'ไม่อนุมัติ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: Container(
                                  width: size.width * 0.1,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kPrimaryColor),
                                  child: Center(
                                    child: Text(
                                      'อนุมัติ',
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
                ],
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
