import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kingdeal/controllers/infinite_scroll_controller.dart';
import 'package:kingdeal/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List products = [];
  late String updateAt;
  Future<void> _pullRefresh() async {
    final res = await ApiService().getDatas();
    setState(() {
      products = jsonDecode(res['data']);
      updateAt = res['updateAt'];
    });
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
        child: const InfiniteScrollView(),
        //   child: ListView(children: <Widget>[
        //     if (products.isEmpty)
        //       const Text('로딩중입니다.')
        //     else
        //       for (dynamic item in products) Card(item: Map.from(item))
        //   ]),
      ),
    );
  }
}

class InfiniteScrollView extends GetView<InfiniteScrollController> {
  const InfiniteScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          controller: controller.scrollController.value,
          itemBuilder: (_, index) {
            // print(controller.hasMore.value);

            if (index < controller.data.length) {
              var datum = controller.data[index];

              return Material(
                // elevation: 10.0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Item(datum: datum),
                ),
              );
            }

            if (controller.hasMore.value || controller.isLoading.value) {
              return const Center(child: RefreshProgressIndicator());
            }

            return Container(
              padding: const EdgeInsets.all(10.0),
              child: const Center(
                child: Column(
                  children: [
                    Text('...'),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => const Divider(),
          itemCount: controller.data.length + 1,
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({super.key, required this.datum});
  final dynamic datum;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  String image = '';
  _ItemState() {
    init();
  }
  Future init() async {
    // print(widget.datum['src']);
    // final response = await http.get(
    //   widget.datum['src'],
    // );
    // print(response);
    // setState(() {
    //   image = response
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${widget.datum["convenienceStoreName"]}',
        style: const TextStyle(fontSize: 20),
      ),
      title: Text(
        '${widget.datum['title']}',
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text('${widget.datum["size"]}개'),
      trailing: Text(
          '${int.parse(widget.datum["price"]) * int.parse(widget.datum["size"])}'),
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
