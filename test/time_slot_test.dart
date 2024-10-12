import 'package:get/get.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_drop_down_controller.dart';
import 'package:test/test.dart';

void main() {

  test(
    'Initial timeslot should be selected',
        () {
      AddReservationTabViewDropDownController _rsddc =
      Get.put(AddReservationTabViewDropDownController());
      expect(_rsddc.selectedTimeSlot, '08:00 - 10:00');
    },
  );

  test(
    'Correct timeslot should be selected for now',
    () {
      AddReservationTabViewDropDownController _rsddc =
          Get.put(AddReservationTabViewDropDownController());

      _rsddc.setSelectedTimeSlotByDateTime(dateTime: DateTime.now());
      expect(_rsddc.selectedTimeSlot, '08:00 - 10:00');
    },
  );

  test(
    'Correct timeslot should be selected for given time',
        () {
      AddReservationTabViewDropDownController _rsddc =
      Get.put(AddReservationTabViewDropDownController());

      _rsddc.setSelectedTimeSlotByDateTime(dateTime: DateTime(2024, 7, 20, 21, 43));
      expect(_rsddc.selectedTimeSlot, '08:00 - 10:00');
    },
  );
}
