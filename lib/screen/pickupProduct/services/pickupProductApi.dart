
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allReceiving.dart';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:poswarehouse/models/receivinggoods.dart';

class PickupProductApi {
  const PickupProductApi();
  
  //// Get คำสั่งซื้อทั้งหมด
  static Future<AllReceiving> getPickups({
    int start = 0,
    int length = 10,
  }) async {
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
  static Future<ReceivingGoods> getPickupsById(
      String stock_purchase_no) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/get_stock_purchase_line/$stock_purchase_no');
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