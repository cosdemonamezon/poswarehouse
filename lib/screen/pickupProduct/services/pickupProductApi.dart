import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allReceiving.dart';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/orderproduct.dart';
import 'package:poswarehouse/models/orders.dart';
import 'package:poswarehouse/models/receivinggoods.dart';
import 'package:poswarehouse/models/stockpurchase.dart';

class PickupProductApi {
  const PickupProductApi();

  //// Get คำสั่งซื้อทั้งหมด
  static Future<Orders> getOrders({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.https(publicUrl, '/pos/public/api/order_page');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "draw": 1,
        "order": [
          {"column": 0, "dir": "asc"}
        ],
        "start": start,
        "length": length,
        "search": {"value": "", "regex": false}
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Orders.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  static Future<AllReceiving> getPickups({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.https(publicUrl, '/pos/public/api/stock_pickout_page');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "draw": 1,
        "order": [
          {"column": 0, "dir": "asc"}
        ],
        "start": start,
        "length": length,
        "search": {"value": "", "regex": false}
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return AllReceiving.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  // Get By Id
  static Future<ReceivingGoods> getPickupsById(String stock_pick_out_no) async {
    final url = Uri.https(publicUrl, '/pos/public/api/get_stock_pickout_line/$stock_pick_out_no');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return ReceivingGoods.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //Create
  static Future<StockPurchase> createPickoutOrders(String date, List<NewOrders> orders) async {
    final url = Uri.https(publicUrl, '/pos/public/api/stock_pickout');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "pick_out_date": date,
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

  //รับสินค้าที่เบิก
  static Future<StockPurchase> receiveStock(String stock_pick_out_no) async {
    final url = Uri.https(publicUrl, '/pos/public/api/receive_stock_pickout');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "stock_pick_out_no": stock_pick_out_no,
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

  // Get By Id ReturnProductPage
  static Future<ReceivingGoods> getReturnProduct(String stock_purchase_no) async {
    final url = Uri.https(publicUrl, '/pos/public/api/get_stock_purchase_damaged/$stock_purchase_no');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return ReceivingGoods.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
