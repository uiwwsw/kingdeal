import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getDatas() async {
    final url = Uri.parse(
      '//kingdeal.duckdns.org/getDatas',
    );
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'matthew1234'});
    if (response.statusCode == 200) {
      // print(response.body);
      return jsonDecode(response.body);
    }
    throw Error();
  }
}
