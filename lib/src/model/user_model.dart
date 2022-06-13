import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/base_model.dart';

class UserModel implements BaseModel {
  String id;
  String name;
  String role;
  String phoneNumber;
  String email;
  String? pictureLink;

  UserModel(
      {required this.id,
      required this.name,
      required this.role,
      required this.phoneNumber,
      required this.email,
      this.pictureLink});
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return UserModel(
        id: data['id'],
        name: data['name'],
        role: data['role'],
        phoneNumber: data['phoneNumber'],
        email: data['email'],
        pictureLink: data['pictureLink']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'phoneNumber': phoneNumber,
      'email': email,
      'pictureLink': pictureLink
    };
  }

  @override
  String toString() {
    return name;
  }

  // Map<String,dynamic> toSignUp(){
  //   return {}
  // }
}

enum Role { customer, technician, admin }
