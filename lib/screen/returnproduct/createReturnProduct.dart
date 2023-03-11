import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';

class CreateReturnProduct extends StatefulWidget {
  CreateReturnProduct({Key? key}) : super(key: key);

  @override
  State<CreateReturnProduct> createState() => _CreateReturnProductState();
}

class _CreateReturnProductState extends State<CreateReturnProduct> {
  final GlobalKey<FormState> returnProductFormKey = GlobalKey<FormState>();
  final TextEditingController returnProductId = TextEditingController();
  final TextEditingController returnProductDate = TextEditingController();
  final TextEditingController returnProductName = TextEditingController();
  final TextEditingController returnProductAddress = TextEditingController();
  final TextEditingController returnProductTel = TextEditingController();
  final TextEditingController returnProductSend = TextEditingController();
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('คืนสินค้า'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Form(
                key: returnProductFormKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
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
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
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
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
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
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                        ],
                      ),
                    ),

                    ///---------------------------
                    Container(
                      child: Column(
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
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
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
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              'ช่องทางจัดส่ง',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                              height: size.height * 0.06,
                              width: size.width * 0.45,
                              child: appTextFormField(
                                controller: returnProductId,
                                sufPress: () {},
                                readOnly: false,
                                vertical: 25.0,
                                horizontal: 10.0,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  }
                                  return null;
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopify_sharp,
                        size: 30,
                      ),
                      Text(
                        'สินค้า',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
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
                height: size.height * 0.01,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: double.infinity,
                child: pickupOrder.isNotEmpty
                    ? DataTable(
                        columns: <DataColumn>[
                            DataColumn(
                              label: Text(''),
                            ),
                            DataColumn(
                              label: Text('รหัส'),
                            ),
                            DataColumn(
                              label: SizedBox(
                                  width: size.width * 0.15,
                                  child: Text('ชื่อสินค้า')),
                            ),
                            DataColumn(
                              label: SizedBox(
                                  width: size.width * 0.05,
                                  child: Text('คงเลือ')),
                            ),
                            DataColumn(
                              label: SizedBox(
                                  width: size.width * 0.04,
                                  child: Center(child: Text('จำนวน'))),
                            ),
                            DataColumn(
                              label: SizedBox(
                                  width: size.width * 0.06,
                                  child: Center(child: Text('หมายเหตู'))),
                            ),
                          ],
                        rows: List<DataRow>.generate(
                            pickupOrder.length,
                            (index) => DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.08);
                                    }
                                    if (index.isEven) {
                                      return Colors.grey.withOpacity(0.3);
                                    }
                                    return null;
                                  }),
                                  cells: <DataCell>[
                                    DataCell(
                                        Text('${pickupOrder[index]['id']}')),
                                    DataCell(
                                        Text('${pickupOrder[index]['poid']}')),
                                    DataCell(
                                        Text('${pickupOrder[index]['name']}')),
                                    DataCell(Text(
                                        '${pickupOrder[index]['amount']}')),
                                    DataCell(
                                      SizedBox(
                                          height: size.height * 0.05,
                                          width: size.width * 0.05,
                                          child: appTextFormField(
                                            controller: returnProductId,
                                            sufPress: () {},
                                            readOnly: false,
                                            vertical: 25.0,
                                            horizontal: 10.0,
                                          )),
                                    ),
                                    DataCell(
                                      SizedBox(
                                          height: size.height * 0.05,
                                          width: double.infinity,
                                          child: appTextFormField(
                                            controller: returnProductId,
                                            sufPress: () {},
                                            readOnly: false,
                                            vertical: 25.0,
                                            horizontal: 10.0,
                                          )),
                                    ),
                                  ],
                                  selected: selected[index],
                                  onSelectChanged: (bool? value) {
                                    setState(() {
                                      selected[index] = value!;
                                    });
                                  },
                                )))
                    : SizedBox(),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
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
                      onTap: () async {},
                      child: Container(
                        width: size.width * 0.2,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'บันทึก',
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
