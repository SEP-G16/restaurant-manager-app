class OrderAddOn {
  int id;
  int addOnId;
  int quantity;
  OrderAddOn({
    required this.id,
    required this.addOnId,
    required this.quantity,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'addOnId' : addOnId,
      'quantity': quantity,
    };
  }

  factory OrderAddOn.fromMap(Map<String, dynamic> map) {
    return OrderAddOn(
      id: map['id'],
      addOnId: map['addOnId'],
      quantity: map['quantity'],
    );
  }

  OrderAddOn copyWith({
    int? id,
    int? addOnId,
    int? quantity,
  }) {
    return OrderAddOn(
      id: id ?? this.id,
      addOnId: addOnId ?? this.addOnId,
      quantity: quantity ?? this.quantity,
    );
  }
}
