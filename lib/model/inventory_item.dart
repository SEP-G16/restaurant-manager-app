class InventoryItem {
  int _id;
  String _name;
  bool _isInStock;
  InventoryItem({required int id, required String name, required bool isInStock}):
    _id = id,
    _name = name,
    _isInStock = isInStock;

  int get id => _id;
  String get name => _name;
  bool get isInStock => _isInStock;

  set id(int id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  set isInStock(bool isInStock) {
    _isInStock = isInStock;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'is_in_stock': _isInStock,
    };
  }

  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      isInStock: map['is_in_stock'],
    );
  }


}