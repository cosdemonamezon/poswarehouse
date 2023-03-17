import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/extension/dateExtension.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/printer.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/unit.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/printer/printerService.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/inputNumberDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:poswarehouse/widgets/unitDialog.dart';
import 'package:provider/provider.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

import '../../widgets/testProduct.dart';

class CreateOrderOffLine extends StatefulWidget {
  CreateOrderOffLine({Key? key}) : super(key: key);

  @override
  State<CreateOrderOffLine> createState() => _CreateOrderOffLineState();
}

class _CreateOrderOffLineState extends State<CreateOrderOffLine> {
  GlobalKey globalKey = GlobalKey();
  final GlobalKey<FormState> _addFormKey = GlobalKey<FormState>();
  TextEditingController textPriceController = TextEditingController();
  TextEditingController textTotalController = TextEditingController();
  final TextEditingController? datePick = TextEditingController();
  final TextEditingController? name = TextEditingController();
  final TextEditingController? phone = TextEditingController();
  final TextEditingController? email = TextEditingController();
  final TextEditingController? address = TextEditingController();
  final TextEditingController searchProduct = TextEditingController();
  FocusNode mainFocusNode = FocusNode();
  String changPrice = '0.00';
  bool isRetailPrice = false;
  bool isWholeSalePrice = false;
  bool isStockSellingPrice = false;
  List multipleSelected = [];
  String gender = "";
  String radioButtonItem = 'ONE';
  int id = 1;
  List<Product> selectProducts = [];
  bool printBinded = false;
  // int paperSize = 0;
  // String serialNumber = "";
  // String printerVersion = "";
  Printer? printer;
  //--------------------------------------------
  DateTime dateTime = DateTime.now();
  List<NewOrders> listneworder = [];
  NewOrders? order;
  int amount = 0;
  int total = 0;
  int vat = 0;
  int alltotal = 0;
  int am = 1;
  List<NewOrders> selectA = [];
  List<Product> edd = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
    _unitinitialize();
    _printerInitail();
    textPriceController.text;
    setState(() {
      radioButtonItem = checkListItems[0]['valuetitle'];
      id = id = int.parse(checkListItems[0]["id"].toString());
      datePick!.text = dateTime.formatTo('yyyy-MM-dd');
    });
  }

  clearValue() {
    setState(() {
      name!.clear();
      phone!.clear();
      email!.clear();
      address!.clear();
      searchProduct.clear();
      listneworder.clear();
      selectProducts.clear();
      textPriceController.clear();
      textTotalController.clear();
      changPrice = '0.00';
    });
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListProducts();

    LoadingDialog.close(context);
  }

  Future<void> test01(String productcode) async {
    print(productcode);
    // await context.read<ProductController>().getListProducts();

    try {
      final abc = await context.read<ProductController>().allProduct!.data;
      await context.read<ProductController>().getDetailProductCode(productcode);

      final product = context.read<ProductController>().productCode!;
      setState(() {
        final found = listneworder.firstWhereOrNull((p) => p.product?.code == product.code);
        inspect(found);
        if (found != null) {
          found.qty = found.qty! + 1;
        } else {
          final newOrder = NewOrders(
            product.id.toString(),
            am,
            double.parse(product.cost!),
            double.parse(product.cost!),
            double.parse(product.price_for_retail!),
            int.parse(product.unit_id!),
            context.read<ProductController>().units!.data![0],
            product,
            false,
          );
          listneworder.add(newOrder);
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialogYes(
            title: 'แจ้งเตือน',
            description: 'ไม่พบสินค้า',
            pressYes: () {
              Navigator.pop(context, true);
            },
          );
        },
      );
    }
  }

  Future<void> _unitinitialize() async {
    await context.read<ProductController>().getListUnits();
  }

  void _printerInitail() {
    _bindingPrinter().then((bool? isBind) async {
      // final size = await SunmiPrinter.paperSize();
      // final version = await SunmiPrinter.printerVersion();
      // final serial = await SunmiPrinter.serialNumber();
      final printer = await SunmiPrinter.getPrinterStatus();

      setState(() {
        printBinded = isBind!;
        // serialNumber = serial;
        // printerVersion = version;
        // paperSize = size;
      });
      if (printer != PrinterStatus.NORMAL) {
        _printerInitail();
      }
      print('printBinded : $printBinded');
      // print('serialNumber : $serialNumber');
      // print('printerVersion : $printerVersion');
      // print('paperSize : $paperSize');
      print('printer : $printer');
    });
  }

  Future<DateTime?> pickDate() =>
      showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(1900), lastDate: DateTime(2100));

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  double sum(List<NewOrders> orders) => orders.fold(0, (previous, o) => previous + (o.qty! * o.price_per_unit!));
  double sumVat(List<NewOrders> orders) => double.parse((sum(orders) * (vat / 100)).toStringAsFixed(2));
  //double newtotal(List<NewOrders> orders) => sum(orders) + sumVat(orders);
  double newtotal(List<NewOrders> orders) => sum(orders);
  int newQty(List<NewOrders> orders) => orders.fold(0, (previousValue, e) => previousValue + e.qty!);

  @override
  void dispose() {
    super.dispose();
    datePick!.dispose();
    name!.dispose();
    phone!.dispose();
    email!.dispose();
    address!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ProductController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('สร้างรายการขาย'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _addFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 6,
                          child: SizedBox(
                            //height: size.height,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.list_alt_rounded),
                                      Text(
                                        "ข้อมูลลูกค้า",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.24,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  labelText: 'รหัสสมาชิก',
                                                  sufPress: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  labelText: 'ชื่อลูกค้า',
                                                  controller: name,
                                                  sufPress: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  labelText: 'อีเมล',
                                                  controller: email,
                                                  sufPress: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.24,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  controller: datePick,
                                                  labelText: 'วันที่',
                                                  sufPress: () async {
                                                    final _pick = await pickDate();
                                                    if (_pick != null) {
                                                      setState(() {
                                                        datePick!.text = _pick.formatTo('yyyy-MM-dd');
                                                      });
                                                    } else {}
                                                  },
                                                  sufIcon: Icons.calendar_month,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  labelText: 'ที่อยู่',
                                                  controller: address,
                                                  sufPress: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.06,
                                                child: appTextTowFormField(
                                                  labelText: 'เบอร์โทร',
                                                  controller: phone,
                                                  sufPress: () {},
                                                  validator: (val) {
                                                    if (val == null || val.isEmpty) {
                                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                                    } else if (RegExp(r'\s').hasMatch(val)) {
                                                      return 'รูปแบบไม่ถูกต้อง';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.shopping_bag),
                                            Text(
                                              "สินค้า",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.06,
                                          width: size.width * 0.12,
                                          child: RawKeyboardListener(
                                            focusNode: mainFocusNode,
                                            autofocus: true,
                                            onKey: (RawKeyEvent event) {
                                              if (event.runtimeType.toString() == 'RawKeyUpEvent') {
                                                //print(event.logicalKey.keyLabel);
                                                setState(() {
                                                  if (event.logicalKey.keyLabel != 'Enter' && event.logicalKey.keyLabel != 'Shift Left') {
                                                    searchProduct.text += event.logicalKey.keyLabel;
                                                  } else if (event.logicalKey.keyLabel == 'Enter') {
                                                    //test.clear();
                                                    print('55555');
                                                    test01(searchProduct.text);
                                                    searchProduct.clear();
                                                    return;
                                                  }
                                                });
                                                //print(event.runtimeType.toString());
                                                //print(event.logicalKey.keyLabel);
                                              }
                                            },
                                            child: TextFormField(
                                              controller: searchProduct,
                                              onFieldSubmitted: (_) async {},
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final _select = await showDialog<List<Product>>(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext context) {
                                                  return TestProduct();
                                                  // return ProductDialog(
                                                  //   title: '',
                                                  //   description: '',
                                                  //   allProduct: controller.allProduct!.data,
                                                  //   productPage: controller.allProduct,
                                                  //   press: () {
                                                  //     Navigator.pop(context);
                                                  //   },
                                                  //   pressSelect: () async {},
                                                  // );
                                                },
                                              );
                                              if (_select != null && _select.isNotEmpty) {
                                                setState(() {
                                                  final List<NewOrders> select = _select
                                                      .map((e) => NewOrders(
                                                          e.id.toString(),
                                                          am,
                                                          double.parse(e.cost!),
                                                          double.parse(e.cost!),
                                                          double.parse(e.price_for_retail!),
                                                          int.parse(e.unit_id!),
                                                          controller.units!.data![0],
                                                          e,
                                                          false))
                                                      .toList();

                                                  listneworder.addAll(select);
                                                });
                                                inspect(listneworder);
                                              } else {
                                                print('object Na data of Select');
                                              }
                                            },
                                            child: Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.05,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                              child: Center(
                                                child: Text(
                                                  'เพิ่มสินค้า',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///--------------------------\\\\
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      checkListItems.length,
                                      (index) => SizedBox(
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: int.parse(checkListItems[index]["id"].toString()),
                                              groupValue: id,
                                              onChanged: (val) {
                                                setState(() {
                                                  radioButtonItem = '${checkListItems[index]["valuetitle"]}';
                                                  id = int.parse(checkListItems[index]["id"].toString());
                                                  if (listneworder.isNotEmpty) {
                                                    if (id == 1) {
                                                      for (var i = 0; i < listneworder.length; i++) {
                                                        // listneworder[i].price_per_unit = checkListItems[index]["cost"];
                                                        listneworder[i].cost =
                                                            double.parse(controller.allProduct!.data![index].price_for_retail!);
                                                      }
                                                    }
                                                    if (id == 2) {
                                                      for (var i = 0; i < listneworder.length; i++) {
                                                        // listneworder[i].price_per_unit = checkListItems[index]["cost"];
                                                        listneworder[i].cost =
                                                            double.parse(controller.allProduct!.data![index].price_for_wholesale!);
                                                      }
                                                    }
                                                    if (id == 3) {
                                                      for (var i = 0; i < listneworder.length; i++) {
                                                        // listneworder[i].price_per_unit = checkListItems[index]["cost"];
                                                        listneworder[i].cost =
                                                            double.parse(controller.allProduct!.data![index].price_for_box!);
                                                      }
                                                    } else {}
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              '${checkListItems[index]["title"]}',
                                              style: TextStyle(fontSize: 17.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /////////////////\\\\\\\\\\\\\
                                  Container(
                                    width: size.width * 0.68,
                                    height: size.height * 0.35,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                    //color: Colors.amber,
                                    child: SingleChildScrollView(
                                      child: listneworder.isNotEmpty
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: DataTable(
                                                  dataRowHeight: size.height * 0.08,
                                                  horizontalMargin: 2,
                                                  columnSpacing: 30,
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text(''),
                                                    ),
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
                                                      label: Center(child: Text('ราคา')),
                                                    ),
                                                    DataColumn(
                                                      label: Text('จำนวน'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('หน่วย'),
                                                    ),
                                                  ],
                                                  rows: List<DataRow>.generate(
                                                      listneworder.length,
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
                                                              DataCell(IconButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      listneworder.removeAt(index);
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons.delete))),
                                                              DataCell(Text('${listneworder[index].product!.code}')),
                                                              DataCell(Text('${listneworder[index].product!.name}')),
                                                              DataCell(SizedBox(
                                                                width: size.width * 0.05,
                                                                height: size.height * 0.07,
                                                                child: listneworder[index].product!.image != null
                                                                    ? Image.network('${listneworder[index].product!.image}',
                                                                        fit: BoxFit.fill)
                                                                    : Image.asset(
                                                                        'assets/images/noimage.jpg',
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                              )),
                                                              DataCell(
                                                                InkWell(
                                                                  onTap: () async {
                                                                    final selectPriceCost = await showDialog<String>(
                                                                      context: context,
                                                                      builder: (BuildContext context) => InputNumberDialog(
                                                                        code: '${listneworder[index].product!.code}',
                                                                      ),
                                                                    );
                                                                    if (selectPriceCost != null) {
                                                                      setState(() {
                                                                        listneworder[index].cost = double.parse(selectPriceCost);
                                                                      });
                                                                      inspect(listneworder);
                                                                    } else {}
                                                                  },
                                                                  child: Container(
                                                                    width: size.width * 0.03,
                                                                    child: Center(child: Text('${listneworder[index].cost}')),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(
                                                                InkWell(
                                                                  onTap: () async {
                                                                    final selectPrice = await showDialog<String>(
                                                                      context: context,
                                                                      builder: (BuildContext context) => InputNumberDialog(),
                                                                    );
                                                                    if (selectPrice != null) {
                                                                      setState(() {
                                                                        listneworder[index].price_per_unit = double.parse(selectPrice);
                                                                      });
                                                                      inspect(listneworder);
                                                                    } else {}
                                                                  },
                                                                  child: Container(
                                                                    width: size.width * 0.03,
                                                                    child: Center(child: Text('${listneworder[index].price_per_unit}')),
                                                                  ),
                                                                ),
                                                              ),
                                                              // DataCell(Center(
                                                              //     child: Text(
                                                              //         '${listneworder[index].product!.price_for_retail}'))),
                                                              // DataCell(Center(
                                                              //     child: Text(
                                                              //         '${listneworder[index].product!.price_for_wholesale}'))),
                                                              // DataCell(Center(
                                                              //     child: Text(
                                                              //         '${listneworder[index].product!.price_for_box}'))),
                                                              // DataCell(Center(
                                                              //     child: Text(
                                                              //         '${listneworder[index].product!.remain}'))),
                                                              DataCell(
                                                                InkWell(
                                                                  onTap: () async {
                                                                    final selectNumber = await showDialog<String>(
                                                                      context: context,
                                                                      builder: (BuildContext context) => InputNumberDialog(),
                                                                    );
                                                                    if (selectNumber != null) {
                                                                      setState(() {
                                                                        listneworder[index].qty = int.parse(selectNumber);
                                                                      });
                                                                      inspect(listneworder);
                                                                    } else {}
                                                                  },
                                                                  child: Container(
                                                                    width: size.width * 0.025,
                                                                    child: Center(child: Text('${listneworder[index].qty}')),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataCell(SizedBox(
                                                                width: size.width * 0.04,
                                                                child: Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () async {
                                                                        final selectUnit = await showDialog<Unit>(
                                                                          context: context,
                                                                          builder: (BuildContext context) => UnitDialog(
                                                                            units: controller.units!.data!,
                                                                          ),
                                                                        );
                                                                        if (selectUnit != null) {
                                                                          setState(() {
                                                                            listneworder[index].unit_id = selectUnit.id;
                                                                            listneworder[index].unit = selectUnit;
                                                                          });
                                                                        } else {}
                                                                      },
                                                                      child: Container(
                                                                        width: size.width * 0.025,
                                                                        child: Center(child: Text('${listneworder[index].unit!.name}')),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                            ],
                                                          ))),
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color(0xFFF3F3F3),
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Container(
                                            width: size.width * 0.22,
                                            //color: Colors.red,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'จำนวนทั้งหมด',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${newQty(listneworder)}',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'รวม',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${sum(listneworder)}',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Text(
                                                //       'ภาษีมูลค่าเพิ่ม',
                                                //       style: TextStyle(
                                                //           fontSize: 16,
                                                //           fontWeight: FontWeight.bold),
                                                //     ),
                                                //     Text(
                                                //       '${sumVat(listneworder)}',
                                                //       style: TextStyle(
                                                //           fontSize: 16,
                                                //           fontWeight: FontWeight.bold),
                                                //     )
                                                //   ],
                                                // ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'รวมทั้งหมด',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${newtotal(listneworder)}',
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),

                      //////
                      Expanded(
                          flex: 4,
                          child: SizedBox(
                            //height: size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.orderProduct != null
                                    ? Text(
                                        'ยอดที่ต้องชำระทั้งหมด',
                                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'ยอดที่ต้องชำระทั้งหมด',
                                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                      ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                SizedBox(
                                  height: size.height * 0.10,
                                  child: TextField(
                                    controller: textTotalController,
                                    readOnly: true,
                                    enabled: false,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 45.0),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  'ช่องรับเงิน',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.10,
                                  child: TextField(
                                    controller: textPriceController,
                                    readOnly: true,
                                    enabled: false,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 45.0),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: size.height * 0.10,
                                //   child: Container(
                                //     decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Text(
                                //           'เงินทอน',
                                //           style: TextStyle(fontSize: 45.0),
                                //         ),
                                //         Text(
                                //           '${changPrice}',
                                //           style: TextStyle(fontSize: 45.0),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Divider(
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    numberPadAdd('50'),
                                    numberPadAdd('100'),
                                    numberPadAdd('500'),
                                    numberPadAdd('1000'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    numberPad('7'),
                                    numberPad('8'),
                                    numberPad('9'),
                                    //numberPad('CE', clear: true),
                                    numberPad('Del', delete: true),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    numberPad('4'),
                                    numberPad('5'),
                                    numberPad('6'),
                                    numberPad('.'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    numberPad('1'),
                                    numberPad('2'),
                                    numberPad('3'),
                                    numberPad('0'),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    controller.orderProduct == null
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (listneworder.isNotEmpty) {
                                                  try {
                                                    for (var i = 0; i < listneworder.length; i++) {
                                                      setState(() {
                                                        if (radioButtonItem == 'retail') {
                                                          listneworder[i].cost = 15;
                                                        } else if (radioButtonItem == 'wholesale') {
                                                          listneworder[i].cost = 13;
                                                        } else {
                                                          listneworder[i].cost = 14;
                                                        }
                                                      });
                                                      LoadingDialog.open(context);
                                                      await context.read<ProductController>().createNewOrder(datePick!.text, name!.text,
                                                          phone!.text, email!.text, address!.text, radioButtonItem, listneworder);
                                                      if (controller.orderProduct != null) {
                                                        LoadingDialog.close(context);
                                                        setState(() {
                                                          textTotalController.text = controller.orderProduct!.selling_price!.toString();
                                                        });
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return AlertDialogYes(
                                                              title: 'สำเร็จ',
                                                              description: 'ดำเนินการสำเร็จ',
                                                              pressYes: () {
                                                                Navigator.pop(context, true);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return AlertDialogYes(
                                                              title: 'แจ้งเตือน',
                                                              description: 'เกิดข้อผิดพลาด',
                                                              pressYes: () {
                                                                Navigator.pop(context, true);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                      LoadingDialog.close(context);
                                                    }
                                                  } on Exception catch (e) {
                                                    LoadingDialog.close(context);
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return AlertDialogYes(
                                                          title: 'แจ้งเตือน',
                                                          description: e.toString(),
                                                          pressYes: () {
                                                            Navigator.pop(context, true);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else {}
                                              },
                                              child: Container(
                                                width: size.width * 0.1,
                                                height: size.height * 0.08,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.grey)),
                                                child: Center(
                                                  child: Text(
                                                    'สร้างออร์เดอร์',
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    controller.orderProduct != null
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (textPriceController.text != "") {
                                                  try {
                                                    LoadingDialog.open(context);
                                                    await context
                                                        .read<ProductController>()
                                                        .confirmNewOrder(controller.orderProduct!.order_no!, (textPriceController.text));
                                                    if (controller.confirmOrder != null) {
                                                      LoadingDialog.close(context);
                                                      setState(() {
                                                        changPrice = controller.confirmOrder!.change.toString();
                                                        printer = new Printer(controller.confirmOrder);

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return AlertDialogChangs(
                                                              title: 'เงินทอน',
                                                              description: '${changPrice} บาท',
                                                              pressYes: () {
                                                                Navigator.pop(context, true);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      });
                                                      await PrinterService().print(printer!);
                                                      clearValue();
                                                      setState(() {
                                                        controller.orderProduct = null;
                                                        if (textPriceController.text != '') {
                                                          //changPrice = textPriceController.text;
                                                        }
                                                      });
                                                    } else {
                                                      LoadingDialog.close(context);
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialogYes(
                                                            title: 'แจ้งเตือน',
                                                            description: 'เกิดข้อผิดพลาด e',
                                                            pressYes: () {
                                                              Navigator.pop(context, true);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    }
                                                  } on Exception catch (e) {
                                                    LoadingDialog.close(context);
                                                    setState(() {
                                                      controller.orderProduct = null;
                                                      textPriceController.clear();
                                                      textTotalController.clear();
                                                    });

                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
                                                        return AlertDialogYes(
                                                          title: 'แจ้งเตือน',
                                                          description: e.toString(),
                                                          pressYes: () {
                                                            Navigator.pop(context, true);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                } else {}
                                              },
                                              child: Container(
                                                width: size.width * 0.1,
                                                height: size.height * 0.08,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                                                child: Center(
                                                  child: Text(
                                                    'ชำระเงิน',
                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                //   child: GestureDetector(
                                //     onTap: () async {
                                //       printer = new Printer(
                                //                             'GP-0125',
                                //                             '12/03/2023',
                                //                             '06.55',
                                //                             '16',
                                //                             '100.00',
                                //                             '100.00',);
                                //       await PrinterService().print(printer!);
                                //     },
                                //     child: Container(
                                //       width: size.width * 0.1,
                                //       height: size.height * 0.08,
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(10),
                                //           color: kPrimaryColor),
                                //       child: Center(
                                //         child: Text(
                                //           'ชำระเงิน',
                                //           style: TextStyle(
                                //               fontSize: 18,
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.white),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget numberPad(
    String text, {
    bool delete = false,
    bool enable = true,
    bool clear = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: enable
            ? () => setState(() {
                  if (clear) {
                    textPriceController.text = '';
                    return;
                  }

                  if (delete) {
                    if (textPriceController.text.isEmpty) {
                      setState(() {
                        textPriceController.text = '0.00';
                      });
                      return;
                    }

                    textPriceController.text = textPriceController.text.substring(0, textPriceController.text.length - 1);
                  } else {
                    {
                      if (text == '.' && textPriceController.text.contains('.')) {
                        return;
                      }

                      if (text == '0' && textPriceController.text.isEmpty) {
                        return;
                      }

                      textPriceController.text += text;
                    }
                  }
                })
            : null,
        child: Container(
          height: 70,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: enable ? Border.all() : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }

  //add
  Widget numberPadAdd(String text) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() {
          textPriceController.text = text;
        }),
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
