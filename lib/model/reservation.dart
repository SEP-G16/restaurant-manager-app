import 'package:restaurant_manager/exception/null_map_key_exception.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class Reservation {
  final int id;
  final String customerName;
  final DateTime reservedDate;
  final int peopleCount;
  final String phoneNo;
  final int timeSlotStart;
  final int timeSlotEnd;
  final List<RestaurantTable> tableList;

  Reservation({
    required this.id,
    required this.customerName,
    required this.reservedDate,
    required this.peopleCount,
    required this.phoneNo,
    required this.timeSlotStart,
    required this.timeSlotEnd,
    required this.tableList,
  }) {
    assert(timeSlotEnd > timeSlotStart);
    assert((timeSlotEnd - timeSlotStart) == 2);
    assert(timeSlotStart % 2 == 0);
    assert(tableList.isNotEmpty);
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    try {
      return Reservation(
        id: map['id'],
        customerName: map['customer_name'],
        reservedDate: DateTime.parse(map['reserved_date']),
        peopleCount: map['people_count'],
        phoneNo: map['phone_no'],
        timeSlotStart: map['time_slot_start'],
        timeSlotEnd: map['time_slot_end'],
        tableList: (map['table_list'] as List<Map<String, dynamic>>)
            .map((tableMap) => RestaurantTable.fromMap(tableMap))
            .toList(),
      );
    } catch (e) {
      print('Error creating Reservation from map : ${e.toString()}');
      throw NullMapKeyException(message: e.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_name': customerName,
      'reserved_date': reservedDate.toIso8601String(),
      'people_count': peopleCount,
      'phone_no': phoneNo,
      'time_slot_start': timeSlotStart,
      'time_slot_end': timeSlotEnd,
      'table_list': tableList.map((table) => table.toMap()).toList(),
    };
  }
}
