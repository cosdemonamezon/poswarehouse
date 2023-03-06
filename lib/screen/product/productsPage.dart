import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/addProducts.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้า'),
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
                                builder: (context) => AddProducts()));
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'เพิ่มสินค้าใหม่',
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
                        label: Text('รหัส'),
                      ),
                      DataColumn(
                        label: Text('ชื่อสินค้า'),
                      ),
                      DataColumn(
                        label: Text('รูปภาพ'),
                      ),
                      DataColumn(
                        label: Text('ราคาทุน'),
                      ),
                      DataColumn(
                        label: Text('ราคาขาย'),
                      ),
                      DataColumn(
                        label: Text('คงเหลือ'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        productList.length,
                        (index) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text('${productList[index]['id']}')),
                                DataCell(Text('${productList[index]['name']}')),
                                DataCell(SizedBox(
                                    height: size.height * 0.10,
                                    width: size.width * 0.10,
                                    child: Center(
                                        child: Image.asset(
                                            '${productList[index]['image']}')))),
                                DataCell(
                                    Text('${productList[index]['price']}')),
                                DataCell(
                                    Text('${productList[index]['saleprice']}')),
                                DataCell(
                                    Text('${productList[index]['total']}')),
                              ],
                            ))),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
