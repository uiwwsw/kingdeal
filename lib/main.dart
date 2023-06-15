import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingdeal/screens/home_screen.dart';

import 'controllers/infinite_scroll_controller.dart';

void main() {
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
