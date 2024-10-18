class AddOn{
  int id;
  String name;
  double price;

  AddOn({required this.id, required this.name, required this.price});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory AddOn.fromMap(Map<String, dynamic> map){
    return AddOn(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }
}