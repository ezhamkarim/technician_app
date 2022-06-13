import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/base_model.dart';

class Service implements BaseModel {
  String id;
  String name;
  double price;
  bool isActive;
  bool selected;

  Service(
      {required this.id,
      required this.name,
      required this.price,
      required this.isActive,
      this.selected = false});

  factory Service.fromObj(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      isActive: json['isActive'],
    );
  }
  factory Service.fromSnapshot(DocumentSnapshot documentSnapshot) {
    var json = documentSnapshot.data() as Map<String, dynamic>;
    return Service(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      isActive: json['isActive'],
    );
  }
  @override
  String toString() {
    return name;
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'isActive': isActive};
  }
}
