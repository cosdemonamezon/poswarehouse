import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allwarehouses.dart';
import 'package:poswarehouse/models/warehouse.dart';

class WareHouseApi {
  const WareHouseApi();

  static Future<AllWareHouses> getSubCategorys() async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/sub_category_page');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "draw": 1,
        "type": "deposit",
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
      return AllWareHouses.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///เพิ่มคลังสินค้า
  static Future<WareHouse> createSubCategory(
      String category_product_id, String name) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/sub_category');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode(
          {"category_product_id": category_product_id, "name": name}),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return WareHouse.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
