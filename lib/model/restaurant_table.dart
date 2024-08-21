class RestaurantTable {
  final int id;
  final int tableNo; //table number
  final int chairCount;

  RestaurantTable({
    required this.id,
    required this.tableNo,
    required this.chairCount,
  });

  factory RestaurantTable.fromMap(Map<String, dynamic> map){
    return RestaurantTable(
      id: map['id'],
      tableNo: map['table_no'],
      chairCount: map['chair_count'],
    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'table_no' : tableNo,
      'chair_count' : chairCount,
    };
  }
}
