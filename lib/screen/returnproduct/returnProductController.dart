import 'package:flutter/material.dart';

import '../../models/order.dart';
import 'returnProductService.dart';

class ReturnProductController extends ChangeNotifier {
  ReturnProductController({this.api = const ReturnProductService()});

  ReturnProductService api;

  List<Order> purchaseDamages = [];
  Order? purchaseDamage;

  Future<void> initialinze() async {
    purchaseDamages = await api.getPurchaseDamages();
    notifyListeners();
  }

  Future<void> getDetail(String id) async {
    purchaseDamage = await api.getReturnProduct(id);
    notifyListeners();
  }
}
