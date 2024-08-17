import 'package:get/get.dart';

class ReservationScreenDateController extends GetxController{
  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(value) => _selectedDate.value = value;
}