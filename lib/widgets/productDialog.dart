import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';

class ProductDialog extends StatefulWidget {
  ProductDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.press})
      : super(key: key);
  final String title, description;
  final VoidCallback press;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: size.width * 0.70,
        height: size.height * 0.55,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: widget.press,
                        icon: Icon(
                          Icons.cancel,
                          size: 30,
                          color: Colors.blueAccent,
                        )),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Center(
                  child: Text('เลือกสินค้า',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text('รหัส'),
                        ),
                        DataColumn(
                          label: Text('ชื่อสินค้า'),
                        ),
                        DataColumn(
                          label: Text('รูปภาพ'),
                        ),
                        DataColumn(
                          label: Text('ราคาส่ง'),
                        ),
                        DataColumn(
                          label: Text('ราคาขายปลีก'),
                        ),
                        DataColumn(
                          label: Text('ราคาขายยกแพ็ค'),
                        ),
                        DataColumn(
                          label: Text('คงเหลือ'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          productList.length,
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
                                  DataCell(Text('${productList[index]['id']}')),
                                  DataCell(Text('${productList[index]['name']}')),
                                  DataCell(Image.asset(
                                      '${productList[index]['image']}')),
                                  DataCell(
                                      Text('${productList[index]['price']}')),
                                  DataCell(
                                      Text('${productList[index]['saleprice']}')),
                                  DataCell(
                                      Text('${productList[index]['packprice']}')),
                                  DataCell(
                                      Text('${productList[index]['total']}')),
                                ],
                                selected: selected[index],
                                onSelectChanged: (bool? value) {
                                  setState(() {
                                    selected[index] = value!;
                                  });
                                },
                              ))),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimaryColor),
                      child: Center(
                        child: Text(
                          'เลือก',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
