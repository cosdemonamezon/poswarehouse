import 'dart:convert' as convert;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/confirmorder.dart';
import 'package:poswarehouse/models/neworders.dart';
import 'package:poswarehouse/models/orderproduct.dart';
import 'package:poswarehouse/models/parade.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/units.dart';

class ProductApi {
  const ProductApi();

  static Future<AllProduct> getProducts({
    int start = 0,
    int length = 10,
  }) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/product_page');
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

  //get by id product
  static Future<Product> getProductById(
    String id,
  ) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/product/$id');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Product.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///Get พาเรทวางสินค้า
  static Future<Parade> getParades() async {
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
    final url = Uri.http(publicUrl, '/pos-api/public/api/unit_page');
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

  static Future<void> createProduct({
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
    final headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'multipart/form-data'
    };
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
    try {
      final response = await Dio().post(
        'http://${publicUrl}/pos-api/public/api/product',
        data: formData,
        options: Options(headers: headers),
      );

      // return Product.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw (e.response?.data['message']);
    }

//  final res = await Dio().post(
//         'https://asha-dev.com/pos-api/public/api/product',
//         data: formData,
//       );
    // if (res.statusCode == 200 || res.statusCode == 201) {
    //   return Product.fromJson(res.data['data']);
    // } else {
    //   throw Exception('อัพโหดลไฟล์ล้มเหลว');
    // }
  }

  // Update Product
  static Future<void> updateProduct({
    required String id,
    required String category_product_id,
    required String sub_category_id,
    required String name,
    required String detial,
    required String cost,
    required String price_for_retail,
    required String price_for_wholesale,
    required String price_for_box,
    required String remain,
    required String remain_shop,
    required String min,
    required XFile file,
    required String code,
    required String units,
  }) async {
    final headers = {
      'Authorization': 'Bearer',
      'Content-Type': 'multipart/form-data'
    };
    var formData = FormData.fromMap(
      {
        'id': id,
        'category_product_id': category_product_id,
        'sub_category_id': sub_category_id,
        'unit_id': 1,
        'name': name,
        'detail': detial,
        'cost': cost,
        'price_for_retail': price_for_retail,
        'price_for_wholesale': price_for_wholesale,
        'price_for_box': price_for_box,
        'remain': remain,
        'remain_shop': remain_shop,
        'min': min,
        'image': await MultipartFile.fromFile(file.path, filename: file.name),
        'code': code,
        'units': units,
      },
    );
    try {
      final response = await Dio().post(
        'http://${publicUrl}/pos-api/public/api/update_product',
        data: formData,
        options: Options(headers: headers),
      );
      
    } on DioError catch (e) {
      throw (e.response?.data['message']);
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

    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer ',
      'Content-Type': 'application/json'
    });

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
    final url =
        Uri.http(publicUrl, '/pos-api/public/api/sub_category/$catagoryId');

    final response = await http.put(url,
        body: jsonEncode({
          "name": title,
        }),
        headers: {
          'Authorization': 'Bearer ',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //สร้างออร์เดอร์ก่อนจ่ายเงิน
  static Future<OrderProduct> newOrder(
      String order_date,
      String name,
      String phone,
      String email,
      String address,
      String type,
      List<NewOrders> orders) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/order');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "order_date": order_date,
        "name": "AAAAA",
        "phone": "0999999999",
        "email": "client@gmail.com",
        "address": "11/11",
        "type": "wholesale",
        "orders": orders,
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return OrderProduct.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //จ่ายเงิน
  static Future<ConfirmOrder> payment(String order_no, String amount) async {
    final url = Uri.http(publicUrl, '/pos-api/public/api/confirm_order');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode(
          {"order_no": order_no, "payment": "cash", "amount": amount}),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return ConfirmOrder.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
