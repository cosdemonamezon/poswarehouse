import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/parade.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';

class ProductController extends ChangeNotifier {
  ProductController({this.api = const ProductApi()});

  ProductApi api;

  List<Product> products = [];
  Parade? parade;
  AllProduct? allProduct;

  getListProducts({
    int start = 0,
    int length = 10,
  }) async {
    allProduct = await ProductApi.getProducts(
      start: start,
      length: length,
    );
    notifyListeners();
  }

  getListParade() async {
    parade = await ProductApi.getParades();
    notifyListeners();
  }
}
