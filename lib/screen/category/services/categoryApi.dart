import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/models/typeProduct.dart';

class CategoryApi {
  const CategoryApi();

  //เรียกดูประเภทสินค้าทั้งหมด
  static Future<AllTypeProduct> getCategorys() async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/category_product_page');
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
      //final list = data['data']['data'] as List;
      return AllTypeProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //สร้างประเภทสินค้า
  static Future<TypeProduct> crateCategorys(String name) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/category_product');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "name": name
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return TypeProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

}
