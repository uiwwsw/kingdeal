import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kingdeal/services/api_service.dart';

class InfiniteScrollController extends GetxController {
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<dynamic> data = <dynamic>[].obs;
  List<dynamic> totalData = [];
  RxInt length = 0.obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = false.obs;

  @override
  void onInit() async {
    _getData();

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });

    super.onInit();
  }

  _getData() async {
    if (totalData.isEmpty) {
      print('djakwldaw');
      var res = await ApiService().getDatas();
      print(res);
      totalData = jsonDecode(res['data']);
    }
    isLoading.value = true;

    List<dynamic> res = getData();
    print(res);

    data.addAll(res);

    isLoading.value = false;
    hasMore.value = res.length > 29;
  }

  List<dynamic> getData() {
    length.value = length.value + 30;
    print(length.value);
    return totalData.sublist(length.value - 30, length.value);
  }
}
