import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:kingdeal/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<dynamic>> data = {};
  Future<void> _pullRefresh() async {
    final res = await ApiService().getDatas();
    // res.values.map((x) => {
    //   data.addAll();
    // });
    setState(() {
      data = res;
    });
    // for (var t in products) {
    //   Map<String, String> d = Map.from(t);
    //   print(d['title']);
    // }
    // prin
  }

  List<dynamic> get products {
    var d = [];
    for (var element in data.values) {
      d.addAll(element);
    }
    // List<Map<String, String>> d = [];
    // for (List<dynamic> elements in data.values) {
    //   for (dynamic element in elements) {
    //     d.add(Map.from(element));
    //   }
    // }
    return d;
  }

  _HomeScreenState() {
    _pullRefresh();
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
        child: ListView(children: <Widget>[
          if (products.isDefinedAndNotNull)
            for (dynamic item in products) Card(item: Map.from(item))
          else
            const Text('Nope. No items here.'),
        ]),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final Map<dynamic, dynamic> item;
  late final String title;
  late final String id;
  late final String src;
  late final String price;
  Card({
    super.key,
    required this.item,
  }) {
    title = item['title'];
    id = item['id'];
    src = item['src'];
    price = item['price'];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        Text(src),
        Text(price),
      ],
    );
  }
}
// class Card extends StatefulWidget {
//   final Map<dynamic, dynamic> item;
//   const Card({super.key, required this.item});

//   @override
//   State<Card> createState() => _CardState();
// }

// class _CardState extends State<Card> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
