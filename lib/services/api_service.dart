import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getDatas() async {
    final url = Uri.parse(
      'http://kingdeal.duckdns.org/getDatas',
    );
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: dotenv.env['SECRET_KEY']!});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Error();
  }
}
