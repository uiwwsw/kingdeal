import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';

  final String today = 'today';

  void getTodaysToons() async {
    final url = Uri.parse('http://localhost:4040');
    final response = await http.get(url, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'http://gs25.gsretail.com',
    });
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
