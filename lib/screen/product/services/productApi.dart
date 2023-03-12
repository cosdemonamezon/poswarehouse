import 'dart:convert' as convert;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/parade.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/units.dart';

class ProductApi {
  const ProductApi();

  static Future<AllProduct> getProducts({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/product_page');
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
      return AllProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///Get พาเรทวางสินค้า
  static Future<Parade> getParades() async {
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
      return Parade.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  // Get Unit
  static Future<Units> getUnits() async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/unit_page');
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
      return Units.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///Create Product

  static Future<Product> createProduct({    
    required String category_product_id,
    required String sub_category_id,
    required String name,
    required String detial,
    required String cost,
    required String price_for_retail,
    required String price_for_wholesale,
    required String price_for_box,
    required XFile file,
    required String code,
    required String units,
  }) async {
    var formData = FormData.fromMap(
      {
        'category_product_id': category_product_id,
        'sub_category_id': sub_category_id,
        'unit_id': 1,
        'name': name,
        'detail': detial,
        'cost': cost,
        'price_for_retail': price_for_retail,
        'price_for_wholesale': price_for_wholesale,
        'price_for_box': price_for_box,
        'remain': 0,
        'remain_shop': 0,
        'min': 0,
        'image': await MultipartFile.fromFile(file.path, filename: file.name),
        'code': code,
        'units': units,
      },
    );

    final res = await Dio().post('https://asha-dev.com/pos-api/public/api/product', data: formData);

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Product.fromJson(res.data['data']);
    } else {
      throw Exception('อัพโหดลไฟล์ล้มเหลว');
    }
  }

  // ลบประเภทสินค้า
  Future<void> deleteSubCatagory({
    required int catagoryId,
  }) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // final token = pref.getString('token');
    final url = Uri.https(
      publicUrl,
      '/pos-api/public/api/sub_category/$catagoryId',
    );

    final response = await http.delete(url, headers: {'Authorization': 'Bearer ', 'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
    } else {
      final data = jsonDecode(response.body);
      throw data['message'];
    }
  }

// แก้ประเภทสินค้า
  Future<bool> changeTitleSubCatagory(
    String title,
    int catagoryId,
  ) async {
    final url = Uri.https(publicUrl, '/pos-api/public/api/sub_category/$catagoryId');

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
