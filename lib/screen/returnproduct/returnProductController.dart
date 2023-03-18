import 'package:flutter/material.dart';

import '../../models/allDamageds.dart';
import '../../models/order.dart';
import 'returnProductService.dart';

class ReturnProductController extends ChangeNotifier {
  ReturnProductController({this.api = const ReturnProductApi()});

  ReturnProductApi api;

  // List<Order> purchaseDamages = [];
  AllDamageds? purchaseDamagesList;
  Order? purchaseDamage;

  // Future<void> initialinze({
  //   int start = 0,
  //   int length = 10,
  //   String? search = '',
  // }) async {
  //   purchaseDamagesList = await api.getPurchaseDamages(
  //     start: start,
  //     length: length,
  //     search: search,
  //   );
  //   notifyListeners();
  // }

  getListPurchaseDamages({
    int start = 0,
    int length = 10,
    String? search = '',
  }) async {
    purchaseDamagesList = await ReturnProductApi.getPurchaseDamages(
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
