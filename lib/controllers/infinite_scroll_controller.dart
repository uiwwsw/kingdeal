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
  RxBool hasMore = true.obs;

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
      final res = await ApiService().getDatas();
      final resData = jsonDecode(res['data']);
      if (resData is List) {
        totalData = resData..shuffle();
      }
    }
    isLoading.value = true;

    var someData = getData();

    data.addAll(someData);

    isLoading.value = false;
    hasMore.value = someData.length > 29;
  }

  List<dynamic> getData() {
    length.value = length.value + 30;
    return totalData.sublist(length.value - 30, length.value);
  }
}
