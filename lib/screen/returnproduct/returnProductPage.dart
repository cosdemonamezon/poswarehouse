import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/returnproduct/createReturnProduct.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';

class ReturnProductPage extends StatefulWidget {
  ReturnProductPage({Key? key}) : super(key: key);

  @override
  State<ReturnProductPage> createState() => _ReturnProductPageState();
}

class _ReturnProductPageState extends State<ReturnProductPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Map<String, dynamic>> itemcell = [
    {
      "id": "1",
      "date": "28/2/2566",
      "number": "DN-02246",
      "name": "ร้านค้าที่ 1",
      "price": "200",
      "status": "สำเร็จ"
    },
    {
      "id": "2",
      "date": "28/2/2566",
      "number": "DN-02247",
      "name": "ร้านค้าที่ 2",
      "price": "300",
      "status": "สำเร็จ"
    },
    {
      "id": "3",
      "date": "28/2/2566",
      "number": "DN-02248",
      "name": "ร้านค้าที่ 3",
      "price": "400",
      "status": "รออนุมัติ"
    },
    {
      "id": "4",
      "date": "28/2/2566",
      "number": "DN-02249",
      "name": "ร้านค้าที่ 4",
      "price": "500",
      "status": "ยกเลิก"
    }
  ];
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: size.width * 0.64,
                      height: size.height * 0.08,
                      child: appTextFormField(
                        sufPress: () {},
                        readOnly: false,
                        preIcon: Icons.search,
                        vertical: 25.0,
                        horizontal: 10.0,
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateReturnProduct()));
                      },
                      child: Container(
                        width: size.width * 0.2,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'สร้างรายการคืนสินค้า',
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
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: double.infinity,
                  child: itemcell.isNotEmpty
                  ?DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('#'),
                        ),
                        DataColumn(
                          label: Text('วันที่'),
                        ),
                        DataColumn(
                          label: Text('หมายเลข'),
                        ),
                        DataColumn(
                          label: Text('ชื่อร้านค้า'),
                        ),
                        DataColumn(
                          label: Text('มูลค่า'),
                        ),
                        DataColumn(
                          label: Text('สถานะ'),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          itemcell.length,
                          (index) => DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
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
                                  DataCell(Text('${itemcell[index]['id']}')),
                                  DataCell(Text('${itemcell[index]['date']}')),
                                  DataCell(Text('${itemcell[index]['number']}')),
                                  DataCell(Text('${itemcell[index]['name']}')),
                                  DataCell(Text('${itemcell[index]['price']}')),
                                  DataCell(Chip(
                                      labelPadding: EdgeInsets.all(2.0),
                                      elevation: 6.0,
                                      shadowColor: Colors.grey[60],
                                      backgroundColor: itemcell[index]['status'] ==
                                              'รออนุมัติ'
                                          ? Colors.orange
                                              : itemcell[index]['status'] ==
                                                      'สำเร็จ'
                                                  ? Colors.green
                                                  : Colors.red,
                                      label: Text(
                                          '${itemcell[index]['status']}'))),
                                  DataCell(Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            
                                          },
                                          icon: Icon(
                                              Icons.remove_red_eye_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.edit_calendar_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.delete)),
                                      IconButton(
                                          onPressed: () async{
                                            
                                          },
                                          icon: Icon(Icons.redeem_sharp)),
                                    ],
                                  ))
                                ],
                                // selected: selected[index],
                                // onSelectChanged: (bool? value) {
                                //   setState(() {
                                //     selected[index] = value!;
                                //   });
                                // },
                              ))):SizedBox(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
