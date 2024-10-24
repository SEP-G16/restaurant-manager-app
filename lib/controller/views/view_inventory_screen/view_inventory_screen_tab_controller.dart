import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ViewInventoryScreenTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      _selectedIndex.value = tabController.index;
      print(selectedIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
