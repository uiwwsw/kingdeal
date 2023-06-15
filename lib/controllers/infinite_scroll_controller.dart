import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InfiniteScrollController<T> extends GetxController {
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<T> data = <T>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = false.obs;

  @override
  void onInit() {
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
    isLoading.value = true;

    List<T> res = await getData();

    data.addAll(res);

    isLoading.value = false;
    hasMore.value = res.length < 30;
  }

  Future<List<T>> getData() async {
    return [];
  }
}
