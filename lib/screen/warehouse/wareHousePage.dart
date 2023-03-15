import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/warehouse/services/wareHouseApi.dart';
import 'package:poswarehouse/screen/warehouse/services/wareHouseController.dart';
import 'package:poswarehouse/screen/warehouse/widgets/DialogEditWareHouse.dart';
import 'package:poswarehouse/screen/warehouse/widgets/DialogWareHouse.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

class WareHousePage extends StatefulWidget {
  WareHousePage({Key? key}) : super(key: key);

  @override
  State<WareHousePage> createState() => WareHousePageState();
}

class WareHousePageState extends State<WareHousePage> {
  final GlobalKey<FormState> warehouseFormKey = GlobalKey<FormState>();
  final TextEditingController? categoryID = TextEditingController();
  final TextEditingController? warehouseName = TextEditingController();
  final TextEditingController? editwarehouseId = TextEditingController();
  final TextEditingController? editwarehouseName = TextEditingController();
  int start = 0;

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {wareHouseApiinitialize(), categoryinitialize()});
  }

  Future<void> categoryinitialize() async {
    await context.read<CategoryController>().getListCategorys();
  }

  Future<void> wareHouseApiinitialize() async {
    LoadingDialog.open(context);
    await context.read<WareHouseController>().getListWareHouses();
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<WareHouseController, CategoryController>(
        builder: (context, controller, categoryController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('คลังสินค้า'),
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
                          final _select = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return DialogWareHouse(
                                warehouseID: categoryID,
                                warehouseName: warehouseName,
                                allCategory: categoryController.allTypeProduct,
                                title: '',
                                description: '',
                                press: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                          if (_select != null) {
                            // inspect(_select.warehouseName);
                            //inspect(_select.categoryId);
                            LoadingDialog.open(context);
                            await context
                                .read<WareHouseController>()
                                .createNewWareHouse(_select.categoryId, _select.warehouseName);
                            if (controller.wareHouse != null) {
                              LoadingDialog.close(context);
                              wareHouseApiinitialize();
                            } else {
                              LoadingDialog.close(context);
                              print('object Error Api response');
                            }
                          } else {
                            print('object Value not Select');
                          }
                        },
                        child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เพิ่มคลังสินค้า',
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
                controller.allWareHouses != null
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: controller.allWareHouses!.data!.isNotEmpty
                            ? DataTable(
                                showCheckboxColumn: false,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Container(
                                        height: size.height * 0.07,
                                        width: size.width * 0.04,
                                        child: Center(child: Text('รหัส'))),
                                  ),
                                  DataColumn(
                                    label: Container(
                                        height: size.height * 0.07,
                                        width: size.width * 0.20,
                                        child: Center(child: Text('ชื่อคลังสินค้า'))),
                                  ),
                                  DataColumn(
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: size.height * 0.07, width: size.width * 0.14, child: Text('')),
                                      ],
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    controller.allWareHouses!.data!.length,
                                    (index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Container(
                                              height: size.height * 0.07,
                                              width: size.width * 0.04,
                                              child: Center(
                                                child: Text('${controller.allWareHouses!.data![index].No}'),
                                              ),
                                            )),
                                            DataCell(Container(
                                              height: size.height * 0.07,
                                              width: size.width * 0.20,
                                              child: Center(
                                                child: Text('${controller.allWareHouses!.data![index].name}'),
                                              ),
                                            )),
                                            DataCell(Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        editwarehouseId!.text =
                                                            '${controller.allWareHouses!.data![index].id}';
                                                        editwarehouseName!.text =
                                                            '${controller.allWareHouses!.data![index].name}';
                                                      });
                                                      final _edit = await showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return DialogEditWareHouse(
                                                            editwarehouseId: editwarehouseId,
                                                            editwarehouseName: editwarehouseName,
                                                            allCategory: categoryController.allTypeProduct,
                                                            title: '',
                                                            description: '',
                                                            press: () {
                                                              Navigator.pop(context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                      if (_edit != null) {
                                                        LoadingDialog.open(context);
                                                        await context.read<WareHouseController>().editWareHouse(_edit.id, _edit.name);
                                                        if (context.read<WareHouseController>().editwareHouse != null) {
                                                          if (!mounted) {return;}
                                                          LoadingDialog.close(context);
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible: false,
                                                            builder: (BuildContext context) {
                                                              return AlertDialogYes(
                                                                title: 'แก้ใขสำเร็จ',
                                                                description: '',
                                                                pressYes: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              );
                                                            },
                                                          );
                                                          wareHouseApiinitialize();
                                                        } else {
                                                          LoadingDialog.close(context);
                                                          print('Edit Error Api');
                                                        }
                                                      } else {
                                                        print('Edit Error');
                                                      }
                                                    },
                                                    icon: Icon(Icons.edit_calendar_outlined)),
                                                IconButton(
                                                    onPressed: () async {
                                                      final _delete = await showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialogYesNo(
                                                            title: 'ยืนยันลบคลังสินค้า',
                                                            description: 'กด ตกลง หากต้องการลบคลังสินค้า',
                                                            pressNo: () {
                                                              Navigator.pop(context, false);
                                                            },
                                                            pressYes: () {
                                                              Navigator.pop(context, true);
                                                            },
                                                          );
                                                        },
                                                      );
                                                      if (_delete == true) {
                                                        //print(_delete);
                                                        LoadingDialog.open(context);
                                                        final delete = await WareHouseApi.deleteSubCategory(
                                                            controller.allWareHouses!.data![index].id);
                                                        if (delete == true) {
                                                          if (!mounted) {return;}
                                                          LoadingDialog.close(context);
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible: false,
                                                            builder: (BuildContext context) {
                                                              return AlertDialogYes(
                                                                title: 'ดำเนินการสำเร็จ',
                                                                description: '',
                                                                pressYes: () {
                                                                  Navigator.pop(context);
                                                                },
                                                              );
                                                            },
                                                          );
                                                          wareHouseApiinitialize();
                                                        } else {
                                                          LoadingDialog.open(context);
                                                          print(delete);
                                                        }
                                                      } else {
                                                        LoadingDialog.open(context);
                                                        print(_delete);
                                                      }
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ))
                                          ],
                                        )))
                            : SizedBox(),
                      )
                    : SizedBox(),
                controller.allWareHouses != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: size.width * 0.22,
                            child: NumberPaginator(
                              numberPages: controller.allWareHouses!.last_page!,
                              config: NumberPaginatorUIConfig(mode: ContentDisplayMode.hidden),
                              onPageChange: (p0) async {
                                LoadingDialog.open(context);
                                setState(() {
                                  start = ((p0 - 1) * start) + 10;
                                  print(start);
                                });
                                await context.read<WareHouseController>().getListWareHouses(start: start);
                                if (!mounted) {
                                  return;
                                }
                                LoadingDialog.close(context);
                              },
                            ),
                          ),
                        ],
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
