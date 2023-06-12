import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  void getDatas() async {
    final url = Uri.parse(
      '//kingdeal.duckdns.org/getDatas',
    );
    print('ㄹ우하하');
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'matthew1234'});
    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    print('오류');
    throw Error();
  }
}
