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
      tableNo: map['tableNo'],
      chairCount: map['chairCount'],
    );
  }

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'tableNo' : tableNo,
      'chairCount' : chairCount,
    };
  }
}
