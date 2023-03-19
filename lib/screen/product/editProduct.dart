import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/parades.dart';
import 'package:poswarehouse/models/subCategory.dart';
import 'package:poswarehouse/models/typeProduct.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';
import 'package:provider/provider.dart';

import '../../models/unit.dart';

class EditProduct extends StatefulWidget {
  EditProduct({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> editProductFormKey = GlobalKey<FormState>();
  final TextEditingController productId = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController detailProduct = TextEditingController();
  final TextEditingController originPrice = TextEditingController();
  final TextEditingController retailPrice = TextEditingController();
  final TextEditingController wholesalePrice = TextEditingController();
  final TextEditingController pricePerCarton = TextEditingController();
  // List<String> list = [];
  ImagePicker picker = ImagePicker();
  XFile? image;
  // List<bool> selected = [];
  int numItems = 0;
  Parades? dropdownValue;
  TypeProduct? categoryValue;
  SubCategory? categoryDetail;
  String images = '';

  List<Unit>? units = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await paradeinitialize();
      await categoryinitialize();
    });
  }

  Future<void> getProduct() async {
    await context.read<ProductController>().getDetailProduct(widget.id);

    final idCategory = context.read<ProductController>().product!.category_product!.id;
    await context.read<CategoryController>().getCategoryById(idCategory);    
    await context.read<CategoryController>().getCategory(idCategory);
    final product = context.read<ProductController>().product;
    final _subCategory = context.read<CategoryController>().getCategoryId;

    setState(() {
      if (_subCategory!.isNotEmpty) {
        categoryDetail = _subCategory[0];
      }
      productId.text = product!.code.toString();
      productName.text = product.name.toString();
      detailProduct.text = product.detail.toString();
      originPrice.text = product.cost.toString();
      retailPrice.text = product.price_for_retail.toString();
      wholesalePrice.text = product.price_for_wholesale.toString();
      pricePerCarton.text = product.price_for_box.toString();

      final _category = context.read<CategoryController>().allTypeProduct;
      final _selectCategory = context.read<CategoryController>().selectCategory;
      final b = _category!.where((element) => element.id == _selectCategory!.id).toList();
      categoryValue = b[0];
      
      images = product.image!;

      for (var unit in units!) {
        if (unit.id.toString() == product.unit_id) {
          unit.selected = true;
        }
      }
    });
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
    //final idCategory = context.read<ProductController>().product!.category_product!.id;
    //await context.read<CategoryController>().getCategory(idCategory);
    //final idCategory = context.read<CategoryController>().allTypeProduct![0].id;
    //await context.read<CategoryController>().getCategoryById(idCategory);
    setState(() {
      // final _category = context.read<CategoryController>().allTypeProduct;
      // final _selectCategory = context.read<CategoryController>().selectCategory;
      // final b = _category!.where((element) => element.id == _selectCategory!.id).toList();
      // categoryValue = b[0];
      //final a = _category!.contains(_selectCategory);
      //categoryValue = context.read<CategoryController>().allTypeProduct![0];
      //categoryValue = context.read<CategoryController>().selectCategory;
      //categoryDetail = context.read<CategoryController>().getCategoryId![0];
    });
    unitsitialize();
  }

  Future<void> unitsitialize() async {
    await context.read<ProductController>().getListUnits();
    if (!mounted) return;

    units = context.read<ProductController>().units!.data;
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ใขสินค้า'),
      ),
      body: Consumer2<ProductController, CategoryController>(builder: (context, controller, controllerCategory, child) {
        return controller.product != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Form(
                        key: editProductFormKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    height: size.height * 0.07,
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
                                    height: size.height * 0.07,
                                    width: size.width * 0.45,
                                    child: appTextFormField(
                                      controller: pricePerCarton,
                                      sufPress: () {},
                                      readOnly: false,
                                      vertical: 25.0,
                                      horizontal: 10.0,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'กรุณากรอกราคายกลัง';
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
                                    height: size.height * 0.07,
                                    width: size.width * 0.45,
                                    child: appTextFormField(
                                      controller: originPrice,
                                      sufPress: () {},
                                      readOnly: false,
                                      vertical: 25.0,
                                      horizontal: 10.0,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'กรุณากรอกราคาทุน';
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
                                        ? categoryValue != null
                                            ? Container(
                                                height: size.height * 0.07,
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
                                        : SizedBox()
                                    : SizedBox(),
                                controllerCategory.getCategoryId != null
                                    ? controllerCategory.getCategoryId!.isNotEmpty
                                        ? context.read<CategoryController>().getCategoryId!.isNotEmpty
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(vertical: 2),
                                                child: Text(
                                                  'คลังสินค้า',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                              )
                                            : SizedBox.shrink()
                                        : SizedBox.shrink()
                                    : SizedBox.shrink(),
                                controllerCategory.getCategoryId != null
                                    ? controllerCategory.getCategoryId!.isNotEmpty
                                        ? context.read<CategoryController>().getCategoryId!.isNotEmpty
                                            ? Container(
                                                height: size.height * 0.07,
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

                            //------------------
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    height: size.height * 0.07,
                                    width: size.width * 0.45,
                                    child: appTextFormField(
                                      controller: productName,
                                      sufPress: () {},
                                      readOnly: false,
                                      vertical: 25.0,
                                      horizontal: 10.0,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'กรุณากรอกชื่อสินค้า';
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
                                    height: size.height * 0.07,
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
                                    height: size.height * 0.07,
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
                                    height: size.height * 0.07,
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
                                SizedBox(
                                  height: size.height * 0.094,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      ///------------------
                      units != null
                          ? SizedBox(
                              child: units!.isNotEmpty
                                  ? Wrap(
                                      children: [
                                        Row(
                                          children: List.generate(
                                            controller.units!.data!.length,
                                            (index) => SizedBox(
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    value: units![index].selected ?? false,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        units![index].selected = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    '${controller.units!.data![index].name}',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            )
                          : SizedBox(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: size.height * 0.18,
                            width: size.width * 0.45,
                            child: SizedBox(
                              height: size.height * 0.12,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final img = await picker.pickImage(source: ImageSource.gallery);
                                      setState(() {
                                        image = img;
                                        images = "";
                                      });
                                    },
                                    child: image == null
                                        ? Container(
                                            width: size.width * 0.16,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                            child: images != ""
                                                ? Image.network(
                                                    images,
                                                    fit: BoxFit.fill,
                                                    height: size.height * 0.54,
                                                    width: size.width * 0.90,
                                                  )
                                                : SizedBox(),
                                          )
                                        : Container(
                                            width: size.width * 0.16,
                                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                            child: Image.file(
                                              File(image!.path),
                                              fit: BoxFit.fill,
                                              height: size.height * 0.54,
                                              width: size.width * 0.90,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: GestureDetector(
                              onTap: () async {
                                editProductFormKey.currentState?.save();

                                if (!editProductFormKey.currentState!.validate()) return;

                                final selectedUnits =
                                    units?.where((u) => u.selected ?? false).toList().map((e) => e.id.toString()).join(',');

                                //Update data
                                LoadingDialog.open(context);
                                try {
                                  await ProductApi.updateProduct(
                                    id: context.read<ProductController>().product!.id.toString(),
                                    category_product_id: categoryValue!.id.toString(),
                                    sub_category_id: categoryDetail!.id.toString(),
                                    name: productName.text,
                                    detial: detailProduct.text,
                                    cost: originPrice.text,
                                    price_for_retail: retailPrice.text,
                                    price_for_wholesale: wholesalePrice.text,
                                    price_for_box: pricePerCarton.text,
                                    remain: context.read<ProductController>().product!.remain.toString(),
                                    remain_shop: context.read<ProductController>().product!.remain_shop.toString(),
                                    min: context.read<ProductController>().product!.min.toString(),
                                    file: image,
                                    code: productId.text,
                                    units: selectedUnits ?? '',
                                  );

                                  if (!mounted) {
                                    return;
                                  }
                                  await context.read<ProductController>().getListProducts();

                                  if (!mounted) {
                                    return;
                                  }

                                  LoadingDialog.close(context);

                                  Navigator.pop(context, true);
                                } catch (e) {
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
              )
            : SizedBox.shrink();
      }),
    );
  }
}
