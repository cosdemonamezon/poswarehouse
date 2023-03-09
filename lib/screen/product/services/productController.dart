import 'package:flutter/material.dart';
import 'package:poswarehouse/models/parade.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';

class ProductController extends ChangeNotifier {
  ProductController({this.api = const ProductApi()});

  ProductApi api;

  List<Product> products = [];
  Parade? parade;

  getListProducts() async{
    products.clear();
    products = await ProductApi.getProducts();
    notifyListeners();
  }

  getListParade() async{
    parade = await ProductApi.getParades();
    notifyListeners();
  }
}