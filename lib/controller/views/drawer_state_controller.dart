import 'package:get/get.dart';

class DrawerStateController extends GetxController {

  static const int RESERVATION_TILE_INDEX = 0;
  static const int ORDER_TILE_INDEX = 1;
  static const int INVENTORY_TILE_INDEX = 2;
  static const int TABLE_TILE_INDEX = 3;
  static const int PAYMENT_TILE_INDEX = 4;

  static DrawerStateController instance = Get.find();

  RxInt _selectedIndex = RESERVATION_TILE_INDEX.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;
}