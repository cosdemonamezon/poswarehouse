import '../../../constants/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../models/login.dart';

class LoginService {
  const LoginService();

  static Future<Login> login(String username, String password) async {
    final url = Uri.https(publicUrl, '/pos/public/api/login');
    final response = await http.post(url, body: {
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Login.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
