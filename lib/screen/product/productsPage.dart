import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/addProducts.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListProducts();    
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProductController>(builder: (context, controller, child) {
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
                Container(
                  decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                  width: double.infinity,
                  child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Center(child: Text('รหัส')),
                        ),
                        DataColumn(
                          label: Center(child: Text('ชื่อสินค้า')),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: size.width * 0.08,
                            child: Center(child: Text('รูปภาพ',textAlign: TextAlign.center,))),
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
                          controller.products.length,
                          (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('${controller.products[index].id}')),
                                  DataCell(Text('${controller.products[index].name}')),
                                  DataCell(SizedBox(
                                    width: size.width * 0.08,
                                    child: Image.asset(
                                        'assets/images/noimage.jpg'),
                                  )),
                                  DataCell(
                                      Center(child: Text('${controller.products[index].cost}'))),
                                  DataCell(
                                      Center(child: Text('${controller.products[index].price_for_retail}'))),
                                  DataCell(
                                      Center(child: Text('${controller.products[index].price_for_wholesale}'))),
                                  DataCell(
                                      Center(child: Text('${controller.products[index].price_for_box}'))),
                                  DataCell(
                                      Center(child: Text('${controller.products[index].remain}'))),
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
  });}
}
