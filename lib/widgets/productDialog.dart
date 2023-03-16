import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/product.dart';

import '../screen/login/widgets/appTextForm.dart';

class ProductDialog extends StatefulWidget {
  ProductDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.press,
    required this.pressSelect,
    this.allProduct,
  }) : super(key: key);
  final String title, description;
  final VoidCallback press;
  final VoidCallback pressSelect;
  //AllProduct? allProduct;
  List<Product>? allProduct;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  // final TextEditingController search = TextEditingController();
  final search = TextEditingController();
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    //products = widget.allProduct!;
    for (var i = 0; i < widget.allProduct!.length; i++) {
      final p = widget.allProduct![i];
      p.selected = false;

      products.add(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Dialog(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: size.width * 0.85,
          height: size.height * 0.85,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: size.width * 0.3,
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      // padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                      child: TextField(
                        controller: search,
                        onChanged: searchProduct,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'ค้นหา',
                          suffixIcon: Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.cancel,
                          size: 30,
                          color: Colors.blueAccent,
                        )),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Center(
                  child: Text('เลือกสินค้า', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Container(
                  //color: Colors.blue,
                  height: size.height * 0.45,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                          child: products.isNotEmpty
                              ? DataTable(
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
                                        label: Center(child: Text('ราคาทุน')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('ราคาขายส่ง')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('ราคาขายปลีก')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('ราคายกลัง')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('คงเหลือ')),
                                      ),
                                    ],
                                  rows: List<DataRow>.generate(
                                      products.length,
                                      (index) => DataRow(
                                            color:
                                                MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                              // All rows will have the same selected color.
                                              if (states.contains(MaterialState.selected)) {
                                                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                              }
                                              // Even rows will have a grey color.
                                              if (index.isEven) {
                                                return Colors.grey.withOpacity(0.3);
                                              }
                                              return null; // Use default value for other states and odd rows.
                                            }),
                                            cells: <DataCell>[
                                              DataCell(Text('${products[index].id}')),
                                              DataCell(Text('${products[index].name}')),
                                              DataCell(SizedBox(
                                                width: size.width * 0.08,
                                                height: size.height * 0.10,
                                                child: products[index].image != null
                                                    ? Image.network('${products[index].image}', fit: BoxFit.fill)
                                                    : Image.asset(
                                                        'assets/images/noimage.jpg',
                                                        fit: BoxFit.fill,
                                                      ),
                                              )),
                                              DataCell(Center(child: Text('${products[index].cost}'))),
                                              DataCell(Center(child: Text('${products[index].price_for_retail}'))),
                                              DataCell(Center(child: Text('${products[index].price_for_wholesale}'))),
                                              DataCell(Center(child: Text('${products[index].price_for_box}'))),
                                              DataCell(Center(child: Text('${products[index].remain}'))),
                                            ],
                                            selected: selected[index],
                                            onSelectChanged: (bool? value) {
                                              setState(() {
                                                selected[index] = value!;
                                                products[index].selected = value;
                                                // if (widget.selectProducts != null) {
                                                //   widget.selectProducts!.add(products.data![index]);
                                                //   newSelectProducts = widget.selectProducts!;
                                                // } else {
                                                //   newSelectProducts.add(products.data![index]);
                                                // }
                                              });
                                            },
                                          )))
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () async {
                      final list = products.where((element) => element.selected == true).toList();
                      Navigator.pop(context, list);
                    },
                    child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                      child: Center(
                        child: Text(
                          'เลือก',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

  void searchProduct(String query) {
    final suggestion = widget.allProduct!.where((product) {
      final productTitle = product.name!.toLowerCase();
      final input = query.toLowerCase();

      return productTitle.contains(input);
    }).toList();

    setState(() => products = suggestion);
  }
}
