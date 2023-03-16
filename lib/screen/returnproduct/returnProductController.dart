import 'package:flutter/material.dart';
import 'package:poswarehouse/models/order.dart';

import 'returnProductService.dart';

class ReturnProductController extends ChangeNotifier {
  ReturnProductController({this.api = const ReturnProductService()});

  ReturnProductService api;

  List<Order> purchaseDamages = [];

  Future<void> initialinze() async {
    purchaseDamages = await api.getPurchaseDamages();
    notifyListeners();
  }
}
