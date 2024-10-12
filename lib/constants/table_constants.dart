import '../model/restaurant_table.dart';

class TableConstants{
  TableConstants._();

  static final List<RestaurantTable> tableList = [
    RestaurantTable(id: 1, tableNo: 101, chairCount: 4),
    RestaurantTable(id: 2, tableNo: 102, chairCount: 6),
    RestaurantTable(id: 3, tableNo: 103, chairCount: 2),
    RestaurantTable(id: 4, tableNo: 104, chairCount: 8),
    RestaurantTable(id: 5, tableNo: 105, chairCount: 4),
  ];

  //Json Format
  /*
  {
    date : '2024-08-19',
    time_slot_start : 8,
    time_slot_end : 10,
    available_tables : [
      {
        id : 1,
        table_no : 101,
        chair_count : 4,
      },
    ],
  }
   */
}