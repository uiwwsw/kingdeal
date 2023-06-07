import 'package:flutter/material.dart';
import 'package:kingdeal/screens/home_screen.dart';
import 'package:kingdeal/services/crawler.dart';

void main() {
  // ApiService().getTodaysToons();
  CrawlerService().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
