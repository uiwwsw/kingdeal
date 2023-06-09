import 'package:http/http.dart' as http;
import 'dart:convert';

String email = "robert@gmail.com";
String password = "123";
String info = "$email:$password";
String encode = base64Encode(info.codeUnits);

String credencials = "Basic $encode";
void main() async {
  final url = Uri.parse('http://127.0.0.1:3032/users');
  dynamic response = await http.get(
    url,
    headers: {'authorization': credencials},
  );
  print(response.body);
}
