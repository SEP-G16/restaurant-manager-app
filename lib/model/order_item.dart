class OrderItem {
  final int id;
  final String menuItemName;
  final List<Map<String, dynamic>>
      addOns; //might need to implement a custom class for this
  final String additionalNotes;
  final int quantity;

  OrderItem({
    required this.id,
    required this.menuItemName,
    required this.addOns,
    required this.additionalNotes,
    required this.quantity,
  });

  String generateAddOnNote() {
    return '';
  }
}
