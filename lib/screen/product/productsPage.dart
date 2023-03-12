import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/addProducts.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController? editSubTitle = TextEditingController();
  int start = 0;
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
                          readOnly: false,
                          preIcon: Icons.search,
                          vertical: 25.0,
                          horizontal: 10.0,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
                        },
                        child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เพิ่มสินค้าใหม่',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                controller.allProduct != null
                    ? Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: controller.allProduct!.data!.isNotEmpty
                            ? DataTable(
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
                                          height: size.height * 0.10,
                                          child: Center(
                                              child: Text(
                                            'รูปภาพ',
                                            textAlign: TextAlign.center,
                                          ))),
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
                                    DataColumn(
                                      label: Center(child: Text('')),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.allProduct!.data!.length,
                                    (index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.allProduct!.data![index].id}')),
                                            DataCell(Text('${controller.allProduct!.data![index].name}')),
                                            DataCell(SizedBox(
                                              width: size.width * 0.08,
                                              height: size.height * 0.10,
                                              child: controller.allProduct!.data![index].image != null
                                                  ? Image.network('${controller.allProduct!.data![index].image}',
                                                      fit: BoxFit.fill)
                                                  : Image.asset(
                                                      'assets/images/noimage.jpg',
                                                      fit: BoxFit.fill,
                                                    ),
                                            )),
                                            DataCell(
                                                Center(child: Text('${controller.allProduct!.data![index].cost}'))),
                                            DataCell(Center(
                                                child:
                                                    Text('${controller.allProduct!.data![index].price_for_retail}'))),
                                            DataCell(Center(
                                                child: Text(
                                                    '${controller.allProduct!.data![index].price_for_wholesale}'))),
                                            DataCell(Center(
                                                child: Text('${controller.allProduct!.data![index].price_for_box}'))),
                                            DataCell(
                                                Center(child: Text('${controller.allProduct!.data![index].remain}'))),
                                            DataCell(Center(
                                                child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext context) => AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                        // backgroundColor: Color.fromARGB(255, 95, 9, 3),
                                                        title: const Text('แก้ไขหัวข้อ'),
                                                        content: appTextFormField(
                                                          controller: editSubTitle,
                                                          sufPress: () {},
                                                          readOnly: false,
                                                          vertical: 0.0,
                                                          horizontal: 0.0,
                                                          validator: (val) {
                                                            if (val == null || val.isEmpty) {
                                                              return 'กรุณากรอกข้อความ';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context, 'Cancel');
                                                              editSubTitle!.clear();
                                                            },
                                                            child: const Text('ยกเลิก'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () async {
                                                              LoadingDialog.open(context);
                                                              await ProductApi().changeTitleSubCatagory(
                                                                  editSubTitle!.text,
                                                                  controller.allProduct!.data![index].id);
                                                              if (mounted) {
                                                                LoadingDialog.close(context);
                                                                editSubTitle!.clear();
                                                                Navigator.pop(context);
                                                                await context
                                                                    .read<ProductController>()
                                                                    .getListProducts();
                                                              }
                                                            },
                                                            child: const Text('แกไข้'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Icon(Icons.edit_calendar_sharp),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext context) => AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15.0),
                                                          ),
                                                          // backgroundColor: Color.fromARGB(255, 95, 9, 3),
                                                          title: const Text('ยืนยัน'),
                                                          content: const Text('ต้องการลบสินค้า'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                              child: const Text('ยกเลิก'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () async {
                                                                LoadingDialog.open(context);
                                                                await ProductApi().deleteSubCatagory(
                                                                    catagoryId: controller.allProduct!.data![index].id);
                                                                if (mounted) {
                                                                  LoadingDialog.close(context);
                                                                  Navigator.pop(context);
                                                                  await context
                                                                      .read<ProductController>()
                                                                      .getListProducts();
                                                                }
                                                              },
                                                              child: const Text('ตกลง'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(Icons.delete)),
                                              ],
                                            ))),
                                          ],
                                        )))
                            : SizedBox(),
                      )
                    : SizedBox(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                controller.allProduct != null
                    ? NumberPaginator(
                        numberPages: controller.allProduct!.last_page!,
                        onPageChange: (p0) async {
                          LoadingDialog.open(context);
                          setState(() {
                            start = ((p0 - 1) * start) + 10;
                            print(start);
                          });
                          await context.read<ProductController>().getListProducts(start: start);
                          if (!mounted) {
                            return;
                          }
                          LoadingDialog.close(context);
                        },
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
