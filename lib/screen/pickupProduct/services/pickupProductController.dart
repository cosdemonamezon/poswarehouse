import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allReceiving.dart';
import 'package:poswarehouse/models/receivinggoods.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductApi.dart';

class PickupProductController extends ChangeNotifier {
  PickupProductController({this.api = const PickupProductApi()});

  PickupProductApi api;

  AllReceiving? allReceiving;

  ReceivingGoods? receivingGoods;

  getListPickupProducts({
    int start = 0,
    int length = 10,
  }) async {
    allReceiving = await PickupProductApi.getPickups();
    notifyListeners();
  }

  getDetail(String stock_purchase_no)async{
    receivingGoods = await PickupProductApi.getPickupsById(stock_purchase_no);
    notifyListeners();
  }
}