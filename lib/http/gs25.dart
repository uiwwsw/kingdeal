
import 'package:http/http.dart' as http;

class Gs25 {
  final String body;

  const Gs25({
    required this.body,
  });

}

Future<Gs25> fetchGs25() async {
  final response = await http
      .get(Uri.parse('http://gs25.gsretail.com/gscvs/ko/products/event-goods'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Gs25(body: response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Gs25');
  }
}
