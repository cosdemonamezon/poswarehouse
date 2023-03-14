import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allwarehouses.dart';
import 'package:poswarehouse/models/warehouse.dart';

class WareHouseApi {
  const WareHouseApi();

  static Future<AllWareHouses> getSubCategorys({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/sub_category_page');
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
        "start": start,
        "length": length,
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
  static Future<WareHouse> createSubCategory(String category_product_id, String name) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/sub_category');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({"category_product_id": category_product_id, "name": name}),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return WareHouse.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //ลบคลังสินค้า
  static deleteSubCategory(int id) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/sub_category/$id');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return (data['status']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //แกใขชื่อคลังสินค้า
  static Future<WareHouse> editSubCategory(int id, String name) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/sub_category/$id');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.put(
      url,
      headers: headers,
      body: convert.jsonEncode({"name": name}),
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
