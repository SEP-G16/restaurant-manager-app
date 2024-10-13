class OrderAddOn {
  int id;
  String name;
  double price;
  int quantity;
  OrderAddOn({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderAddOn.fromMap(Map<String, dynamic> map) {
    return OrderAddOn(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }

  OrderAddOn copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
  }) {
    return OrderAddOn(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
