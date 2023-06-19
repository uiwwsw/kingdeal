import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingdeal/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controllers/infinite_scroll_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(fontFamily: 'Pretendard'),
      initialBinding: AppBinding(),
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InfiniteScrollController());
  }
}
