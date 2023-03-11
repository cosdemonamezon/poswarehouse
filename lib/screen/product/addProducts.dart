import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/parades.dart';
import 'package:poswarehouse/models/typeProduct.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/home/homePage.dart';
import 'package:poswarehouse/screen/login/loginPage.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'dart:io';
import 'dart:async';

import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

import '../../models/subCategory.dart';

class AddProducts extends StatefulWidget {
  AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final TextEditingController productId = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController detailProduct = TextEditingController();
  final TextEditingController originPrice = TextEditingController();
  final TextEditingController retailPrice = TextEditingController();
  final TextEditingController wholesalePrice = TextEditingController();
  final TextEditingController pricePerCarton = TextEditingController();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  Parades? dropdownValue;
  TypeProduct? categoryValue;
  SubCategory? categoryDetail;

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {paradeinitialize(), categoryinitialize()});
  }

  Future<void> paradeinitialize() async {
    LoadingDialog.open(context);
    await context.read<ProductController>().getListParade();
    setState(() {
      dropdownValue = context.read<ProductController>().parade!.data![0];
    });
    LoadingDialog.close(context);
  }

  Future<void> categoryinitialize() async {
    await context.read<CategoryController>().getListCategorys();
    final idCategory = context.read<CategoryController>().allTypeProduct![0].id;
    await context.read<CategoryController>().getCategoryById(idCategory);
    setState(() {
      categoryValue = context.read<CategoryController>().allTypeProduct![0];
      categoryDetail = context.read<CategoryController>().getCategoryId![0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ProductController, CategoryController>(builder: (context, controller, controllerCategory, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('เพิ่มสินค้าใหม่'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Form(
                  key: addProductFormKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.8,
                        //color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'รหัสสินค้า',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: productId,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ราคายกลัง',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: pricePerCarton,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ราคาทุน',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: originPrice,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }
                                    return null;
                                  },
                                )),
                            ////////////
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ประเภทสินค้า',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            controllerCategory.allTypeProduct != null
                                ? controllerCategory.allTypeProduct!.isNotEmpty
                                    ? Container(
                                        height: size.height * 0.08,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromARGB(255, 238, 238, 238)),
                                            color: Color.fromARGB(255, 238, 238, 238),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<TypeProduct>(
                                            value: categoryValue,
                                            icon: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 25,
                                              ),
                                            ),
                                            elevation: 16,
                                            isDense: false,
                                            isExpanded: true,
                                            style: TextStyle(color: Colors.black, fontSize: 16),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (TypeProduct? typeValue) async {
                                              // This is called when the user selects an item.
                                              await context.read<CategoryController>().getCategoryById(typeValue!.id);
                                              setState(() {
                                                categoryValue = typeValue;
                                                if (context.read<CategoryController>().getCategoryId!.isNotEmpty) {
                                                  categoryDetail = context.read<CategoryController>().getCategoryId![0];
                                                }
                                                {
                                                  return;
                                                }
                                              });
                                            },
                                            items: controllerCategory.allTypeProduct!
                                                .map<DropdownMenuItem<TypeProduct>>((TypeProduct typeValue) {
                                              return DropdownMenuItem<TypeProduct>(
                                                value: typeValue,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text('${typeValue.name}'),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                                : SizedBox(),
                            controllerCategory.getCategoryId != null
                                ? controllerCategory.getCategoryId!.isNotEmpty
                                    ? context.read<CategoryController>().getCategoryId!.isNotEmpty
                                        ? Container(
                                            height: size.height * 0.08,
                                            width: size.width * 0.45,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Color.fromARGB(255, 238, 238, 238)),
                                                color: Color.fromARGB(255, 238, 238, 238),
                                                borderRadius: BorderRadius.circular(10)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<SubCategory>(
                                                value: categoryDetail,
                                                icon: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    size: 25,
                                                  ),
                                                ),
                                                elevation: 16,
                                                isDense: false,
                                                isExpanded: true,
                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (SubCategory? detialValue) {
                                                  // This is called when the user selects an item.
                                                  setState(() {
                                                    categoryDetail = detialValue;
                                                  });
                                                },
                                                items: controllerCategory.getCategoryId!
                                                    .map<DropdownMenuItem<SubCategory>>((SubCategory detialValue) {
                                                  return DropdownMenuItem<SubCategory>(
                                                    value: detialValue,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                                      child: Text('${detialValue.name}'),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink()
                                    : SizedBox.shrink()
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),

                      //------------------
                      Container(
                        height: size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ชื่อสินค้า',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: productName,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'รายละเอียดสินค้า',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: detailProduct,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกรายละเอียดสินค้า';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ราคาขายปลีก',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: retailPrice,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'ราคาขายส่ง',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                                height: size.height * 0.08,
                                width: size.width * 0.45,
                                child: appTextFormField(
                                  controller: wholesalePrice,
                                  sufPress: () {},
                                  readOnly: false,
                                  vertical: 25.0,
                                  horizontal: 10.0,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }
                                    return null;
                                  },
                                )),

                            ///------------
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                'พื้นที่จัดเก็บทสินค้า',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            controller.parade != null
                                ? controller.parade!.data!.isNotEmpty
                                    ? Container(
                                        height: size.height * 0.08,
                                        width: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromARGB(255, 238, 238, 238)),
                                            color: Color.fromARGB(255, 238, 238, 238),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Parades>(
                                            value: dropdownValue,
                                            icon: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 25,
                                              ),
                                            ),
                                            elevation: 16,
                                            style: TextStyle(color: Colors.black),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                            onChanged: (Parades? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value;
                                              });
                                            },
                                            items: controller.parade!.data!
                                                .map<DropdownMenuItem<Parades>>((Parades value) {
                                              return DropdownMenuItem<Parades>(
                                                value: value,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text('${value.name}'),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.45,
                      child: SizedBox(
                        height: size.height * 0.12,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                final img = await picker.pickImage(source: ImageSource.camera);
                                setState(() {
                                  image = img;
                                });
                              },
                              child: image == null
                                  ? Container(
                                      width: size.width * 0.12,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          Text(
                                            'เลือกรูปภาพ',
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: size.width * 0.12,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                      child: Image.file(
                                        File(image!.path),
                                        fit: BoxFit.fill,
                                        height: size.height * 0.54,
                                        width: size.width * 0.90,
                                      ),
                                    ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text('xxxxxx.png'),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: GestureDetector(
                        onTap: () async {
                          if (image != null && addProductFormKey.currentState!.validate()) {
                            LoadingDialog.open(context);
                            final _create = await ProductApi.createProduct(
                              category_product_id: categoryValue!.id.toString(),
                              sub_category_id: categoryDetail!.id.toString(),
                              cost: originPrice.text,
                              file: image!,
                              name: productName.text,
                              detial: detailProduct.text,
                              price_for_box: pricePerCarton.text,
                              price_for_retail: retailPrice.text,
                              price_for_wholesale: wholesalePrice.text,
                            );
                            if (_create != null) {
                              LoadingDialog.close(context);
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                            } else {
                              LoadingDialog.open(context);
                              print('object can not create product !!!!!!');
                            }
                          } else {
                            print('object Data is not mat');
                          }
                        },
                        child: Container(
                          width: size.width * 0.2,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              'บันทึก',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
