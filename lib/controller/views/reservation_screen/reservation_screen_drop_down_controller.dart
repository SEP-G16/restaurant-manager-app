import 'package:get/get.dart';

class ReservationScreenDropDownController extends GetxController {
  List<int> _chairCountList = [-1, 2, 4, 6, 8, 12];
  List<int> get chairCountList => _chairCountList;

  List<String> _timeSlots = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '12:00 - 14:00',
    '14:00 - 16:00',
    '16:00 - 18:00',
    '18:00 - 20:00',
    '20:00 - 22:00',
  ];
  List<String> get timeSlots => _timeSlots;

  RxInt _selectedCount = (-1).obs;
  int get selectedCount => _selectedCount.value;
  set selectedCount(value) => _selectedCount.value = value;

  late RxString _selectedTimeSlot;
  String get selectedTimeSlot => _selectedTimeSlot.value;
  set selectedTimeSlot(value) => _selectedTimeSlot.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    _selectedTimeSlot = _timeSlots.first.obs;
    setSelectedTimeSlotByDateTime(dateTime: DateTime.now());
    super.onInit();
  }

  void setSelectedTimeSlotByDateTime({required DateTime dateTime}) {
    if (dateTime.hour >= 22 || dateTime.hour < 8) {
      _selectedTimeSlot.value = _timeSlots.first;
    } else {
      int nextAvailableHour = ((dateTime.hour + 1) / 2).ceil() * 2;
      if (nextAvailableHour >= 24) {
        nextAvailableHour = nextAvailableHour - 24;
      }
      if (nextAvailableHour >= 22 || dateTime.hour < 8) {
        _selectedTimeSlot.value = _timeSlots.first;
      } else {
        String slot = '${nextAvailableHour.toString().padLeft(2, '0')}:00 - ${(nextAvailableHour + 2).toString().padLeft(2, '0')}:00';
        _selectedTimeSlot.value = _timeSlots.firstWhere((s) => s == slot, orElse: () => _timeSlots.first);
      }
    }
  }
}
