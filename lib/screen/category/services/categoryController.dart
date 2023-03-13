import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/models/typeProduct.dart';
import 'package:poswarehouse/screen/category/services/categoryApi.dart';

import '../../../models/subCategory.dart';

class CategoryController extends ChangeNotifier {
  CategoryController({this.api = const CategoryApi()});

  CategoryApi api;

  AllTypeProduct? allTypeProduct2;
  List<TypeProduct>? allTypeProduct;
  List<SubCategory>? getCategoryId;
  TypeProduct? nameCategory;

  getListCategorys2({
    int start = 0,
    int length = 10,
  }) async {
    // products = await ProductApi.getProducts();
    allTypeProduct2 = await CategoryApi.getCategorys2(start: start, length: length);

    notifyListeners();
  }

  // ซื้อสินค้าผ่าน SCB และพร้มเพย์
  getListCategorys() async {
    allTypeProduct?.clear();
    allTypeProduct = await CategoryApi.getCategorys();

    notifyListeners();
  }

  newCategoryCreate(String name) async {
    nameCategory = await CategoryApi.crateCategorys(name);
    notifyListeners();
  }

  getCategoryById(int? id) async {
    getCategoryId = (await CategoryApi.getCategorysById(id)).sub_categorys;
    notifyListeners();
  }
}
