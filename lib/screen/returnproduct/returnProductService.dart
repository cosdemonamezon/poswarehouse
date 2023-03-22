import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:poswarehouse/models/allDamageds.dart';
import 'package:poswarehouse/models/order.dart';

import '../../constants/constants.dart';

class ReturnProductApi {
  const ReturnProductApi();

  static Future<AllDamageds> getPurchaseDamages({
    int start = 0,
    int length = 10,
    String? search = '',
  }) async {
    final url = Uri.https(publicUrl, '/pos/public/api/stock_purchase_damaged_page');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "draw": 1,
        "order": [
          {"column": 1, "dir": "DESC"}
        ],
        "start": start,
        "length": length,
        "search": {"value": search, "regex": false}
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return AllDamageds.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  Future<Order> getReturnProduct(String stock_purchase_no) async {
    final url = Uri.https(publicUrl, '/pos/public/api/get_stock_purchase_damaged/$stock_purchase_no');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Order.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
// class ReturnProductService {
//   const ReturnProductService();

//   //// Get คำสั่งซื้อทั้งหมด
//   // Future<List<Order>> getPurchaseDamages({int start = 0, int length = 10, String? search = ''}) async {
//   //   final url = Uri.https(publicUrl, '/pos/public/api/stock_purchase_damaged_page');
//   //   var headers = {'Content-Type': 'application/json'};
//   //   final response = await http.post(
//   //     url,
//   //     headers: headers,
//   //     body: convert.jsonEncode({
//   //       "draw": 1,
//   //       "order": [
//   //         {"column": 0, "dir": "asc"}
//   //       ],
//   //       "start": start,
//   //       "length": length,
//   //       "search": {"value": search, "regex": false}
//   //     }),
//   //   );

//   //   if (response.statusCode == 200) {
//   //     final data = convert.jsonDecode(response.body);
//   //     final list = data['data']['data'] as List;
//   //     return list.map((e) => Order.fromJson(e)).toList();
//   //   } else {
//   //     final data = convert.jsonDecode(response.body);
//   //     throw Exception(data['message']);
//   //   }
//   // }
//   static Future<AllDamageds> getPurchaseDamages({
//     int start = 0,
//     int length = 10,
//     String? search = '',
//   }) async {
//     final url = Uri.https(publicUrl, '/pos/public/api/stock_purchase_damaged_page');
//     var headers = {'Content-Type': 'application/json'};
//     final response = await http.post(
//       url,
//       headers: headers,
//       body: convert.jsonEncode({
//         "draw": 1,
//         "order": [
//           {"column": 0, "dir": "asc"}
//         ],
//         "start": start,
//         "length": length,
//         "search": {"value": search, "regex": false}
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = convert.jsonDecode(response.body);
//       return AllDamageds.fromJson(data['data']);
//     } else {
//       final data = convert.jsonDecode(response.body);
//       throw Exception(data['message']);
//     }
//   }

//   Future<Order> getReturnProduct(String stock_purchase_no) async {
//     final url = Uri.https(publicUrl, '/pos/public/api/get_stock_purchase_damaged/$stock_purchase_no');
//     var headers = {'Content-Type': 'application/json'};
//     final response = await http.get(
//       url,
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       final data = convert.jsonDecode(response.body);
//       return Order.fromJson(data['data']);
//     } else {
//       final data = convert.jsonDecode(response.body);
//       throw Exception(data['message']);
//     }
//   }
// }
