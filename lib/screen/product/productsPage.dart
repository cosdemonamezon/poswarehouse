import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/addProducts.dart';
import 'package:poswarehouse/screen/product/editProduct.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/GalleryWidget.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../models/product.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController? editSubTitle = TextEditingController();
  int start = 0;
  List<String> images = [];
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  // List<Product> product2 = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListProducts();
    setState(() {
      images = List<String>.generate(context.read<ProductController>().allProduct!.data!.length,
          (index) => context.read<ProductController>().allProduct!.data![index].image!);
      //images.add(context.read<ProductController>().allProduct.data);
      // product2 = context.read<ProductController>().allProduct!.data!;
    });
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
                        width: size.width * 0.60,
                        height: size.height * 0.07,
                        child: appTextFormField(
                          sufPress: () {},
                          readOnly: false,
                          onChanged: (p0) async {
                            print(p0);
                            // if (p0 != '') {
                            //   setState(() {
                            //     product2 = product2.where((product) => product.name!.contains(p0!)).toList();
                            //     // product2 = product2.where((product) {
                            //     //   final productTitle = product.name!.toLowerCase();
                            //     //   final input = p0!.toLowerCase();

                            //     //   return productTitle.contains(input);
                            //     // }).toList();
                            //   });
                            // } else {
                            //   setState(() {
                            //     product2 = controller.allProduct!.data!;
                            //   });
                            // }
                            // Future.delayed(Duration(milliseconds: 500)).then((value) async {/
                            // LoadingDialog.open(context);
                            await context.read<ProductController>().getListProducts(search: p0);
                            // LoadingDialog.close(context);
                            // });///
                          },
                          preIcon: Icons.search,
                          vertical: 25.0,
                          horizontal: 10.0,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          final addpro = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
                          if (addpro == true) {
                            _initialize();
                          } else {
                            print('object No data');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
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
                                dataRowHeight: size.height * 0.10,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Center(child: Text('#')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('ชื่อสินค้า')),
                                  ),
                                  DataColumn(
                                    label: SizedBox(
                                      width: size.width * 0.06,
                                      child: Center(
                                        child: Text(
                                          'รูปภาพ',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
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
                                    label: Center(child: Text('คงเหลือหน้าร้าน')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('')),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    controller.allProduct!.data!.length,
                                    (index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.allProduct!.data![index].No}')),
                                            DataCell(Text('${controller.allProduct!.data![index].name}')),
                                            DataCell(SizedBox(
                                              width: size.width * 0.06,
                                              height: size.height * 0.08,
                                              child: controller.allProduct!.data![index].image != null
                                                  ? InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (_) => GalleryWidget(
                                                                  urlimage: '${controller.allProduct!.data![index].image}',
                                                                )));
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl: '${controller.allProduct!.data![index].image}',
                                                        fit: BoxFit.fill,
                                                        //width: double.infinity,
                                                        placeholder: (context, url) => Center(
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2.0,
                                                          ),
                                                        ),
                                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                                      ))
                                                  : InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (_) => GalleryWidget(
                                                                  urlimage: 'assets/images/noimage.jpg',
                                                                )));
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/noimage.jpg',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                            )),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].cost}'))),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].price_for_retail}'))),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].price_for_wholesale}'))),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].price_for_box}'))),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].remain}'))),
                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].remain_shop}'))),
                                            DataCell(
                                              Center(
                                                  child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final update = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => EditProduct(
                                                                    id: '${controller.allProduct!.data![index].id}',
                                                                  )));
                                                      if (update == true) {
                                                        _initialize();
                                                      } else {
                                                        print('object No data');
                                                      }
                                                      // showDialog<String>(
                                                      //   context: context,
                                                      //   builder: (BuildContext context) => AlertDialog(
                                                      //     shape: RoundedRectangleBorder(
                                                      //       borderRadius: BorderRadius.circular(15.0),
                                                      //     ),
                                                      //     // backgroundColor: Color.fromARGB(255, 95, 9, 3),
                                                      //     title: const Text('แก้ไขหัวข้อ'),
                                                      //     content: appTextFormField(
                                                      //       controller: editSubTitle,
                                                      //       sufPress: () {},
                                                      //       readOnly: false,
                                                      //       vertical: 0.0,
                                                      //       horizontal: 0.0,
                                                      //       validator: (val) {
                                                      //         if (val == null || val.isEmpty) {
                                                      //           return 'กรุณากรอกข้อความ';
                                                      //         }
                                                      //         return null;
                                                      //       },
                                                      //     ),
                                                      //     actions: <Widget>[
                                                      //       TextButton(
                                                      //         onPressed: () {
                                                      //           Navigator.pop(context, 'Cancel');
                                                      //           editSubTitle!.clear();
                                                      //         },
                                                      //         child: const Text('ยกเลิก'),
                                                      //       ),
                                                      //       TextButton(
                                                      //         onPressed: () async {
                                                      //           LoadingDialog.open(context);
                                                      //           await ProductApi().changeTitleSubCatagory(
                                                      //               editSubTitle!.text,
                                                      //               controller.allProduct!.data![index].id);
                                                      //           if (mounted) {
                                                      //             LoadingDialog.close(context);
                                                      //             editSubTitle!.clear();
                                                      //             Navigator.pop(context);
                                                      //             await context
                                                      //                 .read<ProductController>()
                                                      //                 .getListProducts();
                                                      //           }
                                                      //         },
                                                      //         child: const Text('แกไข้'),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // );
                                                    },
                                                    child: Icon(Icons.edit),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
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
                                                            title: Text('ยืนยัน'),
                                                            content: Text('ต้องการลบสินค้า'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                child: Text('ยกเลิก'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  LoadingDialog.open(context);
                                                                  await ProductApi().deleteSubCatagory(
                                                                      catagoryId: controller.allProduct!.data![index].id);
                                                                  if (mounted) {
                                                                    LoadingDialog.close(context);
                                                                    Navigator.pop(context);
                                                                    await context.read<ProductController>().getListProducts();
                                                                  }
                                                                },
                                                                child: Text('ตกลง'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      child: Icon(Icons.delete)),
                                                ],
                                              )),
                                            ),
                                          ],
                                        )))
                            : SizedBox(),
                      )
                    : SizedBox(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                controller.allProduct != null
                    ? SizedBox(
                        width: size.width * 0.22,
                        child: Wrap(
                          children: [
                            NumberPaginator(
                              numberPages: controller.allProduct!.last_page!,
                              config: NumberPaginatorUIConfig(mode: ContentDisplayMode.hidden),
                              onPageChange: (p0) async {
                                LoadingDialog.open(context);
                                // setState(() {
                                //   start = ((p0 - 1) * start) + 10;
                                //   print(start);
                                // });
                                await context.read<ProductController>().getListProducts(start: p0 * 10);
                                if (!mounted) {
                                  return;
                                }
                                LoadingDialog.close(context);
                              },
                            ),
                          ],
                        ),
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
