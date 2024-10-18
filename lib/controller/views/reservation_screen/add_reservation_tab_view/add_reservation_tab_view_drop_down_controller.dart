import 'package:get/get.dart';

import '../../../data/reservation_screen/reservation_data_controller_mixin.dart';

class AddReservationTabViewDropDownController extends GetxController with ReservationDataControllerMixin {

  static AddReservationTabViewDropDownController instance = Get.find();

  List<int> _chairCountList = [-1, 2, 4, 6, 8, 12];
  List<int> get chairCountList => _chairCountList;

  RxInt _selectedCount = (-1).obs;
  RxInt get listenableSelectedCount => _selectedCount;
  int get selectedCount => _selectedCount.value;
  set selectedCount(value) => _selectedCount.value = value;

  late RxString _selectedTimeSlot;
  RxString get listenableSelectedTimeSlot => _selectedTimeSlot;
  String get selectedTimeSlot => _selectedTimeSlot.value;
  set selectedTimeSlot(value) => _selectedTimeSlot.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    _selectedTimeSlot = timeSlots.first.obs;
    setSelectedTimeSlotByDateTime(dateTime: DateTime.now());
    super.onInit();
  }

  void setSelectedTimeSlotByDateTime({required DateTime dateTime}) {
    _selectedTimeSlot.value = getTimeSlotAsString(dateTime);
  }
}
