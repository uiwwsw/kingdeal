import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  Map<String, List<dynamic>> toObject(String str) {
    Map<String, dynamic> map = jsonDecode(str);
    return Map.from(map);
  }

  Future<Map<String, List<dynamic>>> getDatas() async {
    final url = Uri.parse(
      '//kingdeal.duckdns.org/getDatas',
    );
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'matthew1234'});
    if (response.statusCode == 200) {
      return toObject(response.body);
    }
    throw Error();
  }
}
