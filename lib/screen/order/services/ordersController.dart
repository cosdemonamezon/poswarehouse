import 'package:flutter/material.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/stockpurchase.dart';
import 'package:poswarehouse/screen/order/services/ordersApi.dart';
import 'package:poswarehouse/screen/product/services/productApi.dart';

class OrdersController extends ChangeNotifier {
  OrdersController({this.api = const OrdersApi()});

  OrdersApi api;

  StockPurchase? stockPurchase;

  createNewOrder(String date, List<NewOrders> orders) async{
    stockPurchase = await OrdersApi.createOrders(date, orders);
    notifyListeners();
  }
  
}