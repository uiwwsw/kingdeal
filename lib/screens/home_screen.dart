import 'package:flutter/material.dart';
import 'package:kingdeal/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _pullRefresh() async {
    ApiService().getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: const Text(
            "킹받는 킹딜",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(
            children: const [
              Text('ddd'),
              Text('ddd'),
            ],
          ),
        ));
  }
}
