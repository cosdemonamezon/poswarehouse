import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/warehouse/services/wareHouseController.dart';
import 'package:poswarehouse/screen/warehouse/widgets/DialogWareHouse.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
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

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => {wareHouseApiinitialize(), categoryinitialize()});
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
                                  allCategory: categoryController.allTypeProduct!,
                                  title: '',
                                  description: '',
                                  press: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                            if (_select != null) {
                              //inspect(_select.warehouseName);
                              //inspect(_select.categoryId);
                              LoadingDialog.open(context);
                              await context.read<WareHouseController>().createNewWareHouse(_select.categoryId, _select.warehouseName);
                              if (controller.wareHouse != null) {
                                LoadingDialog.close(context);
                                wareHouseApiinitialize();
                              } else {
                                LoadingDialog.close(context);
                                print('object Error Api response');
                              }
                            } else {
                              LoadingDialog.close(context);
                              print('object Value not Select');
                            }
                        },
                        child: Container(
                          width: size.width * 0.1,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'เพิ่มคลังสินค้า',
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
                controller.allWareHouses != null
                    ? Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: controller.allWareHouses!.data!.isNotEmpty
                            ? DataTable(
                                columns: <DataColumn>[
                                    DataColumn(
                                      label: Text('รหัส'),
                                    ),
                                    DataColumn(
                                      label: Text('ชื่อคลังสินค้า'),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    ),
                                  ],
                                rows: List<DataRow>.generate(
                                    controller.allWareHouses!.data!.length,
                                    (index) => DataRow(
                                          // color: MaterialStateProperty.resolveWith<Color?>(
                                          //     (Set<MaterialState> states) {
                                          //   // All rows will have the same selected color.
                                          //   if (states.contains(MaterialState.selected)) {
                                          //     return Theme.of(context)
                                          //         .colorScheme
                                          //         .primary
                                          //         .withOpacity(0.08);
                                          //   }
                                          //   // Even rows will have a grey color.
                                          //   if (index.isEven) {
                                          //     return Colors.grey.withOpacity(0.3);
                                          //   }
                                          //   return null; // Use default value for other states and odd rows.
                                          // }),
                                          cells: <DataCell>[
                                            DataCell(Text(
                                                '${controller.allWareHouses!.data![index].id}')),
                                            DataCell(Text(
                                                '${controller.allWareHouses!.data![index].name}')),
                                            DataCell(Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons
                                                        .remove_red_eye_outlined)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons
                                                        .edit_calendar_outlined)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ))
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
