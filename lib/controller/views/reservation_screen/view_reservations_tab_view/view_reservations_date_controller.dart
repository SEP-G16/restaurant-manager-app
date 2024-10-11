import 'package:get/get.dart';

class ViewReservationsDateController extends GetxController{
  Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;
}