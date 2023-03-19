import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/widgets/GalleryWidget.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../screen/product/services/productController.dart';
import 'LoadingDialog.dart';

class TestProduct extends StatefulWidget {
  const TestProduct({super.key});

  @override
  State<TestProduct> createState() => _TestProductState();
}

class _TestProductState extends State<TestProduct> {
  final search = TextEditingController();
  int start = 0;
  List<String> images = [];
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    await context.read<ProductController>().getListProducts();
    setState(() {
      if (context.read<ProductController>().allProduct != null) {
        images = List<String>.generate(context.read<ProductController>().allProduct!.data!.length,
            (index) => context.read<ProductController>().allProduct!.data![index].image!);
      }
      //images.add(context.read<ProductController>().allProduct.data);
      // product2 = context.read<ProductController>().allProduct!.data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProductController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height * 0.9,
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
                                onChanged: (value) async {
                                  await context.read<ProductController>().getSearchProducts(search: value);
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'ค้นหารหัส',
                                  suffixIcon: Icon(Icons.filter_list),
                                ),
                              ),
                            ),
                            // IconButton(
                            //     onPressed: () async {
                            //       Navigator.pop(context);
                            //     },
                            //     icon: Icon(
                            //       Icons.cancel,
                            //       size: 30,
                            //       color: Colors.blueAccent,
                            //     )),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Text('เลือกสินค้า', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        Container(
                          //color: Colors.blue,
                          height: size.height * 0.465,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                controller.allProduct != null
                                    ? Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: controller.allProduct!.data!.isNotEmpty
                                            ? DataTable(
                                                dataRowHeight: size.height * 0.08,
                                                horizontalMargin: 2,
                                                columnSpacing: 30,
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
                                                    controller.allProduct!.data!.length,
                                                    (index) => DataRow(
                                                          color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
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
                                                            DataCell(Text('${controller.allProduct!.data![index].code}')),
                                                            DataCell(Text('${controller.allProduct!.data![index].name}')),
                                                            DataCell(SizedBox(
                                                              width: size.width * 0.08,
                                                              height: size.height * 0.07,
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
                                                            DataCell(Center(
                                                                child: Text('${controller.allProduct!.data![index].price_for_retail}'))),
                                                            DataCell(Center(
                                                                child: Text('${controller.allProduct!.data![index].price_for_wholesale}'))),
                                                            DataCell(Center(
                                                                child: Text('${controller.allProduct!.data![index].price_for_box}'))),
                                                            DataCell(Center(child: Text('${controller.allProduct!.data![index].remain}'))),
                                                          ],
                                                          selected: controller.allProduct!.data![index].selected ?? false,
                                                          onSelectChanged: (bool? value) {
                                                            setState(() {
                                                              selected[index] = value!;
                                                              controller.allProduct!.data![index].selected = value;
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
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        controller.allProduct != null
                            ? SizedBox(
                                width: size.width * 0.22,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NumberPaginator(
                                      numberPages: controller.allProduct!.last_page!,
                                      config: NumberPaginatorUIConfig(mode: ContentDisplayMode.hidden),
                                      onPageChange: (p0) async {
                                        LoadingDialog.open(context);
                                        // setState(() {
                                        //   //start = ((p0 - 1) * start) + 10;
                                        //   start = ((p0) + start) + 10;
                                        //   print(start);
                                        // });
                                        await context.read<ProductController>().getSearchProducts(start: p0 * 10);
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
                        SizedBox(height: size.height * 0.03),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: GestureDetector(
                            onTap: () async {
                              final list = controller.allProduct!.data!.where((element) => element.selected == true).toList();
                              if (list.isNotEmpty) {
                                Navigator.pop(context, list);
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialogYes(
                                      title: 'ยังไม่ได้เลือกสินค้า',
                                      description: 'โปรดเลือกสินค้าก่อนทำรายการ',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                    );
                                  },
                                );
                              }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
