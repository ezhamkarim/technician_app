import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/base_model.dart';

class TimeSlot implements BaseModel {
  String technicianId;
  String id;
  DateTime date;
  String time;

  TimeSlot(
      {required this.id,
      required this.technicianId,
      required this.time,
      required this.date});

  factory TimeSlot.fromObj(Map<String, dynamic> obj) {
    return TimeSlot(
        id: obj['id'],
        technicianId: obj['technicianId'],
        time: obj['time'],
        date: obj['date'].toDate());
  }
  factory TimeSlot.fromSnapshot(DocumentSnapshot documentSnapshot) {
    var obj = documentSnapshot as Map<String, dynamic>;
    return TimeSlot(
        id: obj['id'],
        technicianId: obj['technicianId'],
        time: obj['time'],
        date: obj['date'].toDate());
  }
  @override
  Map<String, dynamic> toMap() {
    return {'technicianId': technicianId, 'time': time, 'id': id, 'date': date};
  }
}

class Slot implements BaseModel {
  String time;
  String isActive;

  factory Slot.fromObj(Map<String, dynamic> obj) {
    return Slot(time: obj['time'], isActive: obj['isActive']);
  }
  Slot({required this.time, required this.isActive});

  @override
  Map<String, dynamic> toMap() {
    return {'time': time, 'isActive': isActive};
  }
}
