class OrderTable{
  int id;
  int tableNo;

  OrderTable({required this.id, required this.tableNo});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tableNo': tableNo,
    };
  }

  factory OrderTable.fromMap(Map<String, dynamic> map){
    return OrderTable(
      id: map['id'],
      tableNo: map['tableNo'],
    );
  }
}