import 'add_on.dart';

class MenuItem{
  int id;
  String name;
  List<AddOn> addOns;

  MenuItem({required this.id, required this.name, required this.addOns});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'addOns': addOns.map((addOn) => addOn.toMap()).toList(),
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map){
    return MenuItem(
      id: map['id'],
      name: map['name'],
      addOns: map['addOns'] != null ? List<AddOn>.from(map['addOns']?.map((addOn) => AddOn.fromMap(addOn))) : [],
    );
  }
}