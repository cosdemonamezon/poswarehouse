import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/product.dart';

class ProductApi {
  const ProductApi();

  static Future<List<Product>> getProducts() async {
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
        "start": 0,
        "length": 10,
        "search": {"value": "", "regex": false}
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final list = data['data']['data'] as List;
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
