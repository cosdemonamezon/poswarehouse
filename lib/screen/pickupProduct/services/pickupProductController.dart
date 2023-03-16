import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allReceiving.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/order.dart';
import 'package:poswarehouse/models/orderproduct.dart';
import 'package:poswarehouse/models/orders.dart';
import 'package:poswarehouse/models/receivinggoods.dart';
import 'package:poswarehouse/models/stockpurchase.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductApi.dart';

class PickupProductController extends ChangeNotifier {
  PickupProductController({this.api = const PickupProductApi()});

  PickupProductApi api;

  AllReceiving? allReceiving;
  Orders? orders;
  Order? order;

  ReceivingGoods? receivingGoods;
  StockPurchase? stockPurchase;
  ReceivingGoods? returnProduct;
  StockPurchase? receivPurchase;
  StockPurchase? pickOutStockPurchase;

  getListPickupProducts({
    int start = 0,
    int length = 10,
  }) async {
    allReceiving = await PickupProductApi.getPickups();
    notifyListeners();
  }

  getListOrders({
    int start = 0,
    int length = 10,
  }) async {
    orders = await PickupProductApi.getOrders();
    notifyListeners();
  }

  getDetailOrders(String id) async{
    order = await PickupProductApi.getOrderById(id);
    notifyListeners();
  }

  creatOrderPickOut(String date, List<NewOrders> orders) async {
    pickOutStockPurchase = await PickupProductApi.createPickoutOrders(date, orders);
    notifyListeners();
  }

  getDetail(String stock_pick_out_no) async {
    receivingGoods = await PickupProductApi.getPickupsById(stock_pick_out_no);
    notifyListeners();
  }

  receiveStockPickout(String stock_pick_out_no) async {
    receivPurchase = await PickupProductApi.receiveStock(stock_pick_out_no);
    notifyListeners();
  }

  // createNewOrder(String date, List<NewOrders> orders) async {
  //   stockPurchase = await PickupProductApi.createOrders(date, orders);
  //   notifyListeners();
  // }

  getDetailReturnProduct(String stock_purchase_no) async {
    returnProduct = await PickupProductApi.getReturnProduct(stock_purchase_no);
    notifyListeners();
  }
}
