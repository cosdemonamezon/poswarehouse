import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/order/createOrderOffline.dart';
import 'package:poswarehouse/screen/order/detailOrderPage.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Map<String, dynamic>> itemcell = [
    {
      "id": "1",
      "ponum": "PO-02245",
      "name": "ร้าน TT Phone",
      "date": "28/2/2566",
      "status": "รออนุมัติ"
    },
    {
      "id": "2",
      "ponum": "PO-02246",
      "name": "ร้าน TT Phone",
      "date": "2/3/2566",
      "status": "ไม่อนุมัติ"
    },
    {
      "id": "3",
      "ponum": "PO-02247",
      "name": "ร้าน TT Phone",
      "date": "28/2/2566",
      "status": "อนุมัติ"
    },
    {
      "id": "4",
      "ponum": "PO-02248",
      "name": "ร้าน TT Phone",
      "date": "2/2/2566",
      "status": "ยกเลิก"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //inspect(size.width);
    return Scaffold(
      appBar: AppBar(
        title: Text('คำสั่งซื้อ'),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateOrderOffLine()));
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'สร้าง',
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
                        label: Text('ID'),
                      ),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Date'),
                      ),
                      DataColumn(
                        label: Text(''),
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
                                DataCell(Text('${itemcell[index]['ponum']}')),
                                DataCell(Text('${itemcell[index]['name']}')),
                                DataCell(Text('${itemcell[index]['date']}')),
                                DataCell(Chip(
                                    labelPadding: EdgeInsets.all(2.0),
                                    elevation: 6.0,
                                    shadowColor: Colors.grey[60],
                                    backgroundColor:
                                        itemcell[index]['status'] == 'รออนุมัติ'
                                            ? Colors.orange
                                            : itemcell[index]['status'] ==
                                                    'ไม่อนุมัติ'
                                                ? Colors.amber
                                                : itemcell[index]['status'] ==
                                                        'อนุมัติ'
                                                    ? Colors.green
                                                    : Colors.red,
                                    label:
                                        Text('${itemcell[index]['status']}'))),
                                DataCell(Row(
                                  children: [                                    
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailOrderPage()));
                                        },
                                        icon: Icon(Icons.remove_red_eye_outlined)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.edit_calendar_outlined)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
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
            ],
          ),
        ),
      ),
    );
  }
}
