import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/purchase.dart';
import 'package:poswarehouse/models/purchaseProduct.dart';
import 'package:poswarehouse/models/stockpurchase.dart';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class OrdersApi {
  const OrdersApi();

  static Future<StockPurchase> createOrders(
      String date, List<NewOrders> orders) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/stock_purchase');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "purchase_date": date,
        "orders": orders,
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return StockPurchase.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //// Get คำสั่งซื้อทั้งหมด
  static Future<PurchaseProduct> getOrders() async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/stock_purchase_page');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "draw": 1,
        "order": [
          {"column": 0, "dir": "asc"}
        ],
        "start": 0,
        "length": 10,
        "search": {"value": "", "regex": false}
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return PurchaseProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //รับสินค้าเข้าคลัง
  static Future<Purchase> pickupOrders(
      String stock_purchase_no) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/receive_stock_purchase');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "stock_purchase_no": stock_purchase_no,
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Purchase.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
