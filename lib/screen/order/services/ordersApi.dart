import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/stockpurchase.dart';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class OrdersApi {
  const OrdersApi();

  static Future<StockPurchase> createOrders(String date, List<NewOrders> orders) async {
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
}
