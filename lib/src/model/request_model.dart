import 'package:technician_app/src/model/base_model.dart';

class Request implements BaseModel {
  String id;
  String description;
  String status;

  Request({required this.id, required this.description, required this.status});
  factory Request.fromObj(Map<String, dynamic> json) {
    return Request(
        id: json['id'],
        description: json['description'],
        status: json['status']);
  }
  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'description': description, 'status': status};
  }
}
