import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/confirmorder.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/orderproduct.dart';
import 'package:poswarehouse/models/parade.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/units.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';

class ProductController extends ChangeNotifier {
  ProductController({this.api = const ProductApi()});

  ProductApi api;

  List<Product> products = [];
  Parade? parade;
  AllProduct? allProduct;
  Units? units;
  OrderProduct? orderProduct;
  ConfirmOrder? confirmOrder;
  Product? product;
  Product? productCode;

  getListProducts({
    int start = 0,
    int length = 10,
    String? search = '',
  }) async {
    allProduct = await ProductApi.getProducts(
      start: start,
      length: length,
      search: search,
    );
    // allProduct!.data!.sort((a, b) => b.id.compareTo(a.id));
    notifyListeners();
  }

  getDetailProduct(String id) async {
    product = await ProductApi.getProductById(id);
    notifyListeners();
  }

  getDetailProductCode(String code) async {
    productCode = await ProductApi.getProductByIdCode(code);
    notifyListeners();
  }

  getListParade() async {
    parade = await ProductApi.getParades();
    notifyListeners();
  }

  getListUnits() async {
    units = await ProductApi.getUnits();
    notifyListeners();
  }

  confirmNewOrder(String order_no, String amount) async {
    confirmOrder = await ProductApi.payment(order_no, amount);
    notifyListeners();
  }

  createNewOrder(String order_date, String name, String phone, String email, String address, String type,
      List<NewOrders> orders) async {
    orderProduct = await ProductApi.newOrder(order_date, name, phone, email, address, type, orders);
    notifyListeners();
  }
}
