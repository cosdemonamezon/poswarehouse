import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  final GlobalKey<FormState> warehouseFormKey = GlobalKey<FormState>();
  final TextEditingController? warehouseID = TextEditingController();
  final TextEditingController? warehouseName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ประเภทสินค้าทั้งหมด'),
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
                        preIcon: Icons.search,
                        vertical: 25.0,
                        horizontal: 10.0,
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DialogOk(
                              warehouseID: warehouseID,
                              warehouseName: warehouseName,
                              title: 'รอตรวจสอบ',
                              description: 'รายการนี้กำลังรอ ทีมแอดมินตรวจสอบ',
                              press: () {
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
                            'สร้างประเภทสินค้า',
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
                height: size.height * 0.02,
              ),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('ประเภทสินค้า'),
                      ),
                      DataColumn(
                        label: Text('พื้นที่เก็บสินค้า'),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        4,
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
                                DataCell(Text(
                                    '${productType[index]['typeProduct']}')),
                                DataCell(Text(
                                    '${productType[index]['warehouseID']}')),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.remove_red_eye)),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit_calendar_sharp),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                )),
                              ],
                              selected: selected[index],
                              onSelectChanged: (bool? value) {
                                setState(() {
                                  selected[index] = value!;
                                });
                              },
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
