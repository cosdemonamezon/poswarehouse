import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/screen/category/services/categoryApi.dart';

class CategoryController extends ChangeNotifier {
  CategoryController({this.api = const CategoryApi()});

  CategoryApi api;
  
  AllTypeProduct? allTypeProduct;

  getListCategorys() async{
    // products = await ProductApi.getProducts();
    allTypeProduct = await CategoryApi.getCategorys();
    notifyListeners();
  }
}