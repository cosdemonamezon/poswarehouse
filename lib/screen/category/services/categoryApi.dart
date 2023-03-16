import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/models/typeProduct.dart';

class CategoryApi {
  const CategoryApi();

  //เรียกดูประเภทสินค้าทั้งหมด
  static Future<List<TypeProduct>> getCategorys() async {
    final url = Uri.https(publicUrl, '/pos/public/api/category_product_page');
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
      final list = data['data']['data'] as List;
      return list.map((e) => TypeProduct.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  static Future<AllTypeProduct> getCategorys2({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.https(publicUrl, '/pos/public/api/category_product_page');
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
      //final list = data['data']['data'] as List;
      return AllTypeProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //get array ย่อย Categorys
  static Future<TypeProduct> getCategorysById(int? idCategorys) async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // final token = prefs.getString('token');
    final headers = {'Authorization': 'Bearer', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, 'pos/public/api/category_product/$idCategorys');
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return TypeProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //สร้างประเภทสินค้า
  static Future<TypeProduct> crateCategorys(String name) async {
    final url = Uri.https(publicUrl, '/pos/public/api/category_product');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({"name": name}),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return TypeProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  // ลบประเภทสินค้า
  Future<void> deleteCatagory({
    required int catagoryId,
  }) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // final token = pref.getString('token');
    final url = Uri.https(
      publicUrl,
      '/pos/public/api/category_product/$catagoryId',
    );

    final response = await http.delete(url, headers: {'Authorization': 'Bearer ', 'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
    } else {
      final data = jsonDecode(response.body);
      throw data['message'];
    }
  }

// แก้ประเภทสินค้า
  Future<bool> changeTitleCatagory(
    String title,
    int catagoryId,
  ) async {
    final url = Uri.https(publicUrl, '/pos/public/api/category_product/$catagoryId');

    final response = await http.put(url,
        body: jsonEncode({
          "name": title,
        }),
        headers: {'Authorization': 'Bearer ', 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
