import 'package:flutter/material.dart';
import 'package:kingdeal/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, List<dynamic>> data;
  Future<void> _pullRefresh() async {
    final res = await ApiService().getDatas();
    // res.values.map((x) => {
    //   data.addAll();
    // });
    setState(() {
      data = res;
    });
    // for (var t in products) {
    //   String a = t;
    //   print(jsonDecode(t));
    // }
    // prin
  }

  List<dynamic> get products {
    var d = [];
    for (var element in data.values) {
      d.addAll(element);
    }
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
        child: ListView(children: const <Widget>[
          // if (products.isNotEmpty)
          //   for (var item in products) Text(item?.title)
          // else
          //   const Text('Nope. No items here.'),
        ]),
      ),
    );
  }
}
