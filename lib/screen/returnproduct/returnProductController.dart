import 'package:flutter/material.dart';

import '../../models/order.dart';
import 'returnProductService.dart';

class ReturnProductController extends ChangeNotifier {
  ReturnProductController({this.api = const ReturnProductService()});

  ReturnProductService api;

  List<Order> purchaseDamages = [];
  Order? purchaseDamage;

  Future<void> initialinze({
    int start = 0,
    int length = 10,
    String? search = '',
  }) async {
    purchaseDamages = await api.getPurchaseDamages(
      start: start,
      length: length,
      search: search,
    );
    notifyListeners();
  }

  Future<void> getDetail(String id) async {
    purchaseDamage = await api.getReturnProduct(id);
    notifyListeners();
  }
}
