class InventoryItem {
  final int id;
  final String name;
  final bool isInStock;
  InventoryItem({required this.id, required this.name, required this.isInStock});

  set id(value) => id = value;
  set name(value) => name = value;
  set isInStock(value) => isInStock = value;
}