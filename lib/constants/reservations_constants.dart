import 'package:restaurant_manager/model/restaurant_table.dart';

import '../model/reservation.dart';

class ReservationsConstants {
  ReservationsConstants._();

  static final List<Reservation> reservations = [
    Reservation(
      id: 1,
      customerName: 'John Clark',
      reservedDate: DateTime(2024, 9, 25),
      peopleCount: 8,
      phoneNo: '0771234566',
      timeSlotStart: 12,
      timeSlotEnd: 14,
      tableList: [
        RestaurantTable(id: 1, tableNo: 101, chairCount: 4),
        RestaurantTable(id: 5, tableNo: 105, chairCount: 4),
      ],
    ),
    Reservation(
      id: 2,
      customerName: 'Jane Smith',
      reservedDate: DateTime(2024, 9, 25),
      peopleCount: 4,
      phoneNo: '0779876543',
      timeSlotStart: 18,
      timeSlotEnd: 20,
      tableList: [
        RestaurantTable(id: 2, tableNo: 102, chairCount: 4),
      ],
    ),
    Reservation(
      id: 3,
      customerName: 'Alice Brown',
      reservedDate: DateTime(2024, 9, 25),
      peopleCount: 6,
      phoneNo: '0771122334',
      timeSlotStart: 18,
      timeSlotEnd: 20,
      tableList: [
        RestaurantTable(id: 3, tableNo: 103, chairCount: 6),
      ],
    ),
    Reservation(
      id: 4,
      customerName: 'Bob Green',
      reservedDate: DateTime(2024, 9, 26),
      peopleCount: 10,
      phoneNo: '0775566778',
      timeSlotStart: 14,
      timeSlotEnd: 16,
      tableList: [
        RestaurantTable(id: 4, tableNo: 104, chairCount: 6),
        RestaurantTable(id: 6, tableNo: 106, chairCount: 4),
      ],
    ),
    Reservation(
      id: 5,
      customerName: 'Charlie White',
      reservedDate: DateTime(2024, 9, 27),
      peopleCount: 2,
      phoneNo: '0773344556',
      timeSlotStart: 16,
      timeSlotEnd: 18,
      tableList: [
        RestaurantTable(id: 7, tableNo: 107, chairCount: 2),
      ],
    ),
  ];
}
