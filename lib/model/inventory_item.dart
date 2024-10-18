import 'package:restaurant_manager/enum/menu_item_status.dart';

class InventoryItem {
  int _id;
  String _name;
  MenuItemStatus _status;
  InventoryItem({required int id, required String name, required MenuItemStatus status}):
    _id = id,
    _name = name,
    _status = status;

  int get id => _id;
  String get name => _name;
  MenuItemStatus get status => _status;

  set id(int id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  set status(MenuItemStatus status) {
    _status = status;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'status': _status.asString,
    };
  }

  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'],
      name: map['name'],
      status: MenuItemStatus.fromString(map['status']),
    );
  }


}