import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kingdeal/controllers/infinite_scroll_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

final oCcy = NumberFormat('###,###');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd banner;

  _HomeScreenState() {
    banner = BannerAd(
      adUnitId: Platform.isAndroid
          ? dotenv.env['AND_BANNER_KEY']!
          : dotenv.env['IOS_BANNER_KEY']!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    )..load();
    // final BannerAdListener listener = BannerAdListener(
    //   // Called when an ad is successfully received.
    //   onAdLoaded: (Ad ad) => print('Ad loaded.'),
    //   // Called when an ad request failed.
    //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
    //     // Dispose the ad here to free resources.
    //     ad.dispose();
    //     print('Ad failed to load: $error');
    //   },
    //   // Called when an ad opens an overlay that covers the screen.
    //   onAdOpened: (Ad ad) => print('Ad opened.'),
    //   // Called when an ad removes an overlay that covers the screen.
    //   onAdClosed: (Ad ad) => print('Ad closed.'),
    //   // Called when an impression occurs on the ad.
    //   onAdImpression: (Ad ad) => print('Ad impression.'),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "핫딜보다 쎈, 킹딜",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.transparent,
        child: AdWidget(
          ad: banner,
        ),
      ),
      body: const InfiniteScrollView(),
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
          child: RefreshIndicator(
            onRefresh: () => controller.onReset(),
            child: ListView.separated(
              controller: controller.scrollController.value,
              itemBuilder: (_, index) {
                // print(controller.hasMore.value);

                if (index < controller.data.length) {
                  var datum = controller.data[index];

                  return Material(
                    // elevation: 10.0,
                    child: Container(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Item(datum: datum),
                    ),
                  );
                }

                if (controller.hasMore.value || controller.isLoading.value) {
                  return const Center(child: LinearProgressIndicator());
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
          )),
    );
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.datum});
  final dynamic datum;

  get price => oCcy.format(int.parse(datum["price"]));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double?>(
          (Set<MaterialState> states) => 0,
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white.withOpacity(0.1);
            }
            return Colors.white.withOpacity(0);
          },
        ),
      ),
      onPressed: () => launchUrl(
        Uri.parse('${datum['link']}'),
      ),
      child: ListTile(
        leading: Image.asset(
            'assets/icons/${datum["convenienceStoreName"]}.png',
            width: 40,
            fit: BoxFit.fill),
        title: Text(
          '${datum['title']}',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          '${datum["size"]}개',
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Text(price, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

// class _ItemState extends State<Item> {
//   // String image = '';
//   // _ItemState() {
//   //   init();
//   // }
//   // Future init() async {
//   //   // print(widget.datum['src']);
//   //   // final response = await http.get(
//   //   //   widget.datum['src'],
//   //   // );
//   //   // print(response);
//   //   // setState(() {
//   //   //   image = response
//   //   // });
//   // }

//   get price => oCcy.format(
//       int.parse(widget.datum["price"]) * int.parse(widget.datum["size"]));

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.asset(
//           'assets/icons/${widget.datum["convenienceStoreName"]}.png',
//           width: 100),
//       title: Text(
//         '${widget.datum['title']}',
//         style: const TextStyle(fontSize: 18),
//       ),
//       subtitle: Text(
//         '${widget.datum["size"]}개',
//         style: const TextStyle(fontSize: 20),
//       ),
//       trailing: Text(price, style: const TextStyle(fontSize: 16)),
//     );
//   }
// }

// class Card extends StatelessWidget {
//   final Map<dynamic, dynamic> item;
//   late final String title;
//   late final String id;
//   late final String link;
//   late final String src;
//   late final String price;
//   Card({
//     super.key,
//     required this.item,
//   }) {
//     title = item['title'];
//     id = item['id'];
//     link = item['link'];
//     src = item['src'];
//     price = item['price'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(title),
//         Text(src),
//         Text(price),
//       ],
//     );
//   }
// }
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
