import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/homereport.dart';
import 'package:poswarehouse/models/report.dart';

class HomeApi {
  const HomeApi();

  static getReport(String year) async {
    final url = Uri.https(publicUrl, '/pos/public/api/order_report_year/$year');
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(url,headers: headers,);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return data['data'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}