import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/widgets/productDialog.dart';

class CreateOrderOffLine extends StatefulWidget {
  CreateOrderOffLine({Key? key}) : super(key: key);

  @override
  State<CreateOrderOffLine> createState() => _CreateOrderOffLineState();
}

class _CreateOrderOffLineState extends State<CreateOrderOffLine> {
  GlobalKey globalKey = GlobalKey();
  TextEditingController textPriceController = TextEditingController();
  String changPrice = '0.00';

  @override
  void initState() {
    super.initState();
    textPriceController.text = '0.00';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างรายการขาย'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      //height: size.height,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.list_alt_rounded),
                                Text(
                                  "ข้อมูล",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.24,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: Text(
                                            'รหัส',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.001),
                                          child: appTextFormField(
                                            sufPress: () {},
                                            vertical: 5.0,
                                            horizontal: 5.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            'ชื่อลูกค้า',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.001),
                                          child: appTextFormField(
                                            sufPress: () {},
                                            vertical: 5.0,
                                            horizontal: 5.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.24,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            'วันที่',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.001),
                                          child: appTextFormField(
                                            sufPress: () {},
                                            sufIcon: Icons.calendar_month,
                                            vertical: 5.0,
                                            horizontal: 5.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Text(
                                            'เบอร์โทร',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.001),
                                          child: appTextFormField(
                                            sufPress: () {},
                                            vertical: 5.0,
                                            horizontal: 5.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.shopping_bag),
                                      Text(
                                        "สินค้า",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      )
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
                                              title: 'รอตรวจสอบ',
                                              description:
                                                  'รายการนี้กำลังรอ ทีมแอดมินตรวจสอบ',
                                              press: () {
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: size.width * 0.1,
                                        height: size.height * 0.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kPrimaryColor),
                                        child: Center(
                                          child: Text(
                                            'เพิ่มสินค้า',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /////////////////\\\\\\\\\\\\\
                            Container(
                              width: size.width * 0.68,
                              height: size.height * 0.40,
                              color: Colors.amber,
                              child: SingleChildScrollView(
                                child: SizedBox(
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
                                          label: Text('ราคาขาย'),
                                        ),
                                        DataColumn(
                                          label: Text('ยอดรวม'),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          newitemcell.length,
                                          (index) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text(
                                                      '${newitemcell[index]['id']}')),
                                                  DataCell(Text(
                                                      '${newitemcell[index]['itemcode']}')),
                                                  DataCell(Text(
                                                      '${newitemcell[index]['name']}')),
                                                  DataCell(Text(
                                                      '${newitemcell[index]['amount']}')),
                                                  DataCell(Text(
                                                      '${newitemcell[index]['price']}')),
                                                  DataCell(Text(
                                                      '${newitemcell[index]['total']}')),
                                                ],
                                              ))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: size.width * 0.22,
                                  color: Colors.red,
                                  child: Column(
                                    children: [
                                      Row(
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
                                      Row(
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
                                      Row(
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
                                      Row(
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),

                //////
                Expanded(
                    flex: 4,
                    child: SizedBox(
                      //height: size.height,
                      child: Column(
                        children: [
                          Text(
                            'ยอดที่ต้องชำระทั้งหมด 2,118.6',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            height: size.height * 0.10,
                            child: TextField(
                              controller: textPriceController,
                              readOnly: true,
                              enabled: false,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 45.0),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            height: size.height * 0.10,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'เงินทอน',
                                    style: TextStyle(fontSize: 45.0),
                                  ),
                                  Text(
                                    '${changPrice}',
                                    style: TextStyle(fontSize: 45.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              numberPadAdd('50'),
                              numberPadAdd('100'),
                              numberPadAdd('500'),
                              numberPadAdd('1000'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              numberPad('7'),
                              numberPad('8'),
                              numberPad('9'),
                              //numberPad('CE', clear: true),
                              numberPad('Del', delete: true),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              numberPad('4'),
                              numberPad('5'),
                              numberPad('6'),
                              numberPad('.'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              numberPad('1'),
                              numberPad('2'),
                              numberPad('3'),
                              numberPad('0'),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      changPrice = '0.00';
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      if (textPriceController.text != '') {
                                        changPrice = textPriceController.text;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: size.width * 0.1,
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
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget numberPad(
    String text, {
    bool delete = false,
    bool enable = true,
    bool clear = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: enable
            ? () => setState(() {
                  if (clear) {
                    textPriceController.text = '';
                    return;
                  }

                  if (delete) {
                    if (textPriceController.text.isEmpty) {
                      setState(() {
                        textPriceController.text = '0.00';
                      });
                      return;
                    }

                    textPriceController.text = textPriceController.text
                        .substring(0, textPriceController.text.length - 1);
                  } else {
                    {
                      if (text == '.' &&
                          textPriceController.text.contains('.')) {
                        return;
                      }

                      if (text == '0' && textPriceController.text.isEmpty) {
                        return;
                      }

                      textPriceController.text += text;
                    }
                  }
                })
            : null,
        child: Container(
          height: 70,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: enable ? Border.all() : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }

  //add
  Widget numberPadAdd(String text) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          textPriceController.text = text;
        }),
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
