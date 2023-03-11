import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/createOrderOffline.dart';
import 'package:poswarehouse/screen/saleItems/detailSaleItem.dart';

class SaleItemsPage extends StatefulWidget {
  SaleItemsPage({Key? key}) : super(key: key);

  @override
  State<SaleItemsPage> createState() => _SaleItemsPageState();
}

class _SaleItemsPageState extends State<SaleItemsPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Map<String, dynamic>> itemcell = [
    {
      "id": "1",
      "date": "28/2/2566",
      "number": "SO-02245",
      "name": "Mr.suthap",
      "price": "200",
      "status": "สำเร็จ"
    },
    {
      "id": "2",
      "date": "10/2/2566",
      "number": "SO-02245",
      "name": "Mr.suthap",
      "price": "200",
      "status": "สำเร็จ"
    },
    {
      "id": "3",
      "date": "18/2/2566",
      "number": "SO-02245",
      "name": "Mr.suthap",
      "price": "200",
      "status": "สำเร็จ"
    },
    {
      "id": "4",
      "date": "29/2/2566",
      "number": "SO-02249",
      "name": "Mr.suthap 2",
      "price": "500",
      "status": "ยกเลิก"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการขาย'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateOrderOffLine()));
                      },
                      child: Container(
                        width: size.width * 0.2,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'สร้างรายการขาย',
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
              SizedBox(
                width: double.infinity,
                child: DataTable(
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
                        label: Text('ชื่อลูกค้า'),
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
                                DataCell(Text('${itemcell[index]['id']}')),
                                DataCell(Text('${itemcell[index]['date']}')),
                                DataCell(Text('${itemcell[index]['number']}')),
                                DataCell(Text('${itemcell[index]['name']}')),
                                DataCell(Text('${itemcell[index]['price']}')),
                                DataCell(Chip(
                                    labelPadding: EdgeInsets.all(2.0),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    backgroundColor:
                                        itemcell[index]['status'] == 'สำเร็จ'
                                            ? Colors.green
                                            : Colors.red,
                                    label:
                                        Text('${itemcell[index]['status']}'))),
                                DataCell(IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailSaleItem()));
                                    },
                                    icon: Icon(Icons.more_vert)))
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
