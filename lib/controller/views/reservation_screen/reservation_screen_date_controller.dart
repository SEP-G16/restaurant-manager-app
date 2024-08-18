import 'package:get/get.dart';

class ReservationScreenDateController extends GetxController {
  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;

  void _init() {
    //setting correct date
    DateTime now = DateTime.now();

    if (now.hour >= 20) {
      now = now.add(
        Duration(
          days: 1,
        ),
      );
    }

    _selectedDate.value = now;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _init();
    super.onInit();
  }
}
