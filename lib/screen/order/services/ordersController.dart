import 'package:flutter/material.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/purchase.dart';
import 'package:poswarehouse/models/purchaseProduct.dart';
import 'package:poswarehouse/models/purchaseorders.dart';
import 'package:poswarehouse/models/stockpurchase.dart';
import 'package:poswarehouse/screen/order/services/ordersApi.dart';

class OrdersController extends ChangeNotifier {
  OrdersController({this.api = const OrdersApi()});

  OrdersApi api;

  StockPurchase? stockPurchase;

  PurchaseProduct? purchaseProduct;
  Purchase? purchase;
  PurchaseOrders? purchaseOrders;

  createNewOrder(String date, List<NewOrders> orders) async {
    stockPurchase = await OrdersApi.createOrders(date, orders);
    notifyListeners();
  }

  getListOrders({
    int start = 0,
    int length = 10,
  }) async {
    purchaseProduct = await OrdersApi.getOrders(
      start: start,
      length: length,
    );
    notifyListeners();
  }

  pickupNewOrders(String stock_purchase_no) async {
    purchase = await OrdersApi.pickupOrders(stock_purchase_no);
    notifyListeners();
  }

  getDetailPurchase(String stock_purchase_no) async {
    purchaseOrders = await OrdersApi.getOrderById(stock_purchase_no);
    notifyListeners();
  }
}
