import 'package:restaurant_manager/exception/null_map_key_exception.dart';
import 'package:restaurant_manager/extension/date_time_extension.dart';
import 'package:restaurant_manager/model/restaurant_table.dart';

class Reservation {
  final int id;
  final String customerName;
  final DateTime reservedDate;
  final int peopleCount;
  final String phoneNo;
  String? email;
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
    this.email,
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
        customerName: map['customerName'],
        reservedDate: DateTime.parse(map['reservedDate']),
        peopleCount: map['peopleCount'],
        phoneNo: map['phoneNo'],
        timeSlotStart: map['timeSlotStart'],
        timeSlotEnd: map['timeSlotEnd'],
        tableList: (map['restaurantTableList'] as List<dynamic>).map((decoded) => decoded as Map<String, dynamic>)
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
      'customerName': customerName,
      'reservedDate': reservedDate.toIsoFormattedDateTime(),
      'peopleCount': peopleCount,
      'phoneNo': phoneNo,
      'timeSlotStart': timeSlotStart,
      'timeSlotEnd': timeSlotEnd,
      'restaurantTableList': tableList.map((table) => table.toMap()).toList(),
    };
  }

  Reservation copyWith({
    int? id,
    String? customerName,
    DateTime? reservedDate,
    int? peopleCount,
    String? phoneNo,
    String? email,
    int? timeSlotStart,
    int? timeSlotEnd,
    List<RestaurantTable>? tableList,
  }) {
    return Reservation(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      reservedDate: reservedDate ?? this.reservedDate,
      peopleCount: peopleCount ?? this.peopleCount,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      timeSlotStart: timeSlotStart ?? this.timeSlotStart,
      timeSlotEnd: timeSlotEnd ?? this.timeSlotEnd,
      tableList: tableList ?? this.tableList,
    );
  }
}
