import 'package:get/get.dart';
import 'package:restaurant_manager/controller/views/reservation_screen/add_reservation_tab_view/add_reservation_tab_view_controller.dart';

import '../../../../model/form_valid_response.dart';

class AddReservationScreenStateController extends GetxController {
  static AddReservationScreenStateController get instance =>
      Get.isRegistered<AddReservationScreenStateController>()
          ? Get.find<AddReservationScreenStateController>()
          : Get.put(AddReservationScreenStateController());

  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s'-]+$");
  final RegExp _phoneRegExp = RegExp(r"^\+?(\d[\d-. ]+)?(\([\d-. ]+\))?[\d-. ]+\d$");
  final RegExp _emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  String? _firstName = '';
  String? _lastName = '';
  String? _phoneNo = '';
  String? _email = '';

  int _peopleCount = 0;
  DateTime _selectedDate = DateTime.now();
  String _timeSlot = '08:00 - 10:00';

// Getters
  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get phoneNo => _phoneNo;

  String? get email => _email;

  int get peopleCount => _peopleCount;

  DateTime get selectedDate => _selectedDate;

  String get timeSlot => _timeSlot;

// Setters
  set firstName(String? value) {
    _firstName = value;
  }

  set lastName(String? value) {
    _lastName = value;
  }

  set phoneNo(String? value) {
    _phoneNo = value;
  }

  set email(String? value) {
    _email = value;
  }

  set peopleCount(int value) {
    _peopleCount = value;
  }

  set selectedDate(DateTime value) {
    _selectedDate = value;
  }

  set timeSlot(String value) {
    _timeSlot = value;
  }

  FormValidResponse validateForm() {
    final validationRules = [
      {'condition': _firstName == null || _firstName == '', 'message': 'First Name cannot be empty!'},
      {'condition': !_nameRegExp.hasMatch(_firstName!), 'message': 'First Name is not valid'},
      {'condition': _lastName != null && _lastName != '' && !_nameRegExp.hasMatch(_lastName!), 'message': 'Last Name is invalid!'},
      {'condition': _phoneNo == null || _phoneNo == '', 'message': 'Phone Number cannot be empty!'},
      {'condition': !_phoneRegExp.hasMatch(_phoneNo!), 'message': 'Phone Number is not valid'},
      {'condition': _email != null && _email != '' && !_emailRegExp.hasMatch(_email!), 'message': 'Email is not valid'},
    ];

    for (final rule in validationRules) {
      if (rule['condition'] as bool) {
        return FormValidResponse(formValid: false, message: rule['message'] as String);
      }
    }
    return FormValidResponse(formValid: true);
  }

  Future<void> addReservation() async {
    await AddReservationTabViewController.instance.addReservation(firstName!, lastName, phoneNo!, email, timeSlot, peopleCount);
  }
}
