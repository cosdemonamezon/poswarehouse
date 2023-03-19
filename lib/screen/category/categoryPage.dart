import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/category/services/categoryApi.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int start = 0;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  final GlobalKey<FormState> warehouseFormKey = GlobalKey<FormState>();
  final TextEditingController? warehouseID = TextEditingController();
  final TextEditingController? warehouseName = TextEditingController();
  final TextEditingController? editTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    //await context.read<CategoryController>().getListCategorys();
    await context.read<CategoryController>().getListCategorys2();
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<CategoryController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ประเภทสินค้าทั้งหมด'),
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
                          final text = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return DialogOk(
                                warehouseID: warehouseID,
                                warehouseName: warehouseName,
                                title: 'รอตรวจสอบ',
                                description: 'รายการนี้กำลังรอ ทีมแอดมินตรวจสอบ',
                                press: () {
                                  Navigator.pop(context);
                                },
                                pressSave: () async {
                                  if (warehouseName!.text != "") {
                                    Navigator.pop(context, warehouseName!.text);
                                  }
                                },
                              );
                            },
                          );
                          if (text != null) {
                            //inspect(text);
                            await context.read<CategoryController>().newCategoryCreate(text);
                            if (controller.nameCategory != null) {
                              print('object **** Success');
                              _initialize();
                            } else {
                              print('object **** UnSuccess');
                            }
                          } else {
                            print('object No Data');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'สร้างประเภทสินค้า',
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
                controller.allTypeProduct2?.data?.isNotEmpty ?? false
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: controller.allTypeProduct2!.data!.isNotEmpty
                            ? DataTable(
                                columns: <DataColumn>[
                                    DataColumn(
                                      label: Text('#รหัส'),
                                    ),
                                    DataColumn(
                                      label: Text('ประเภทสินค้า'),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.allTypeProduct2!.data!.length,
                                    (index) => DataRow(
                                          color: MaterialStateProperty
                                              .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                            // All rows will have the same selected color.
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.08);
                                            }
                                            // Even rows will have a grey color.
                                            if (index.isEven) {
                                              return Colors.grey
                                                  .withOpacity(0.3);
                                            }
                                            return null; // Use default value for other states and odd rows.
                                          }),
                                          cells: <DataCell>[
                                            DataCell(Text('${controller.allTypeProduct2!.data![index].No}')),
                                            DataCell(Text('${controller.allTypeProduct2!.data![index].name}')),
                                            DataCell(Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext context) => AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                        // backgroundColor: Color.fromARGB(255, 95, 9, 3),
                                                        title: const Text('แก้ไขหัวข้อ'),
                                                        content: appTextFormField(
                                                          controller: editTitle,
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
                                                              editTitle!.clear();
                                                            },
                                                            child: const Text('ยกเลิก'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () async {
                                                              LoadingDialog.open(context);
                                                              await CategoryApi().changeTitleCatagory(editTitle!.text,
                                                                  controller.allTypeProduct2!.data![index].id);
                                                              if (mounted) {
                                                                LoadingDialog.close(context);
                                                                editTitle!.clear();
                                                                Navigator.pop(context);
                                                                await context
                                                                    .read<CategoryController>()
                                                                    .getListCategorys();
                                                              }
                                                            },
                                                            child: const Text('แกไข้'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.edit),
                                                ),
                                                IconButton(
                                                  onPressed: () {
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
                                                              await CategoryApi().deleteCatagory(
                                                                  catagoryId:
                                                                      controller.allTypeProduct2!.data![index].id);
                                                              if (mounted) {
                                                                LoadingDialog.close(context);
                                                                Navigator.pop(context);
                                                                await context
                                                                    .read<CategoryController>()
                                                                    .getListCategorys();
                                                              }
                                                            },
                                                            child: const Text('ตกลง'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(Icons.delete),
                                                ),
                                              ],
                                            )),
                                          ],
                                          // selected: selected[index],
                                          // onSelectChanged: (bool? value) {
                                          //   setState(() {
                                          //     selected[index] = value!;
                                          //   });
                                          // },
                                        )))
                            : SizedBox(),
                      )
                    : SizedBox(),
                // controller.allProduct != null
                controller.allTypeProduct2 != null
                ?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: size.width * 0.22,
                      child: NumberPaginator(
                        numberPages: controller.allTypeProduct2?.last_page ?? 1,
                        config: NumberPaginatorUIConfig(mode: ContentDisplayMode.hidden),
                        onPageChange: (p0) async {
                          LoadingDialog.open(context);
                          // setState(() {
                          //   start = ((p0 - 1) * start) + 10;
                          //   print(start);
                          // });
                          await context.read<CategoryController>().getListCategorys2(start: p0 * 10);
                          if (!mounted) {
                            return;
                          }
                          LoadingDialog.close(context);
                        },
                      ),
                    ),
                  ],
                ): SizedBox.shrink(),
                // : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
