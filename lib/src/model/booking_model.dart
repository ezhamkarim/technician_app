import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/base_model.dart';
import 'package:technician_app/src/model/request_model.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/model/time_slot_model.dart';

class Booking implements BaseModel {
  String id;
  List<Service> services;
  DateTime dateTime;
  List<TimeSlot> timeSlot;
  double total;
  List<Request> requests;
  String status;
  bool isFeedback;
  String feedbackId;
  String technicianId;
  String phoneNumberTechnician;

  Booking(
      {required this.id,
      required this.services,
      required this.dateTime,
      required this.timeSlot,
      required this.total,
      required this.requests,
      required this.status,
      required this.isFeedback,
      required this.feedbackId,
      required this.technicianId,
      required this.phoneNumberTechnician});
  factory Booking.fromSnapshot(DocumentSnapshot documentSnapshot) {
    var data = documentSnapshot.data() as Map<String, dynamic>;
    var services = data['services'] as List;
    var _requests = data['requests'] as List;
    var _timeSlot = data['timeSlot'] as List;
    return Booking(
        id: data['id'],
        services: services.map((e) => Service.fromObj(e)).toList(),
        dateTime: data['dateTime'].toDate(),
        timeSlot: _timeSlot.map((e) => TimeSlot.fromObj(e)).toList(),
        total: data['total'],
        requests: _requests.map((e) => Request.fromObj(e)).toList(),
        status: data['status'],
        isFeedback: data['isFeedback'],
        feedbackId: data['feedbackId'],
        technicianId: data['technicianId'],
        phoneNumberTechnician: data['phoneNumberTechnician']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'services': services.map((e) => e.toMap()).toList(),
      'dateTime': dateTime,
      'timeSlot': timeSlot.map((e) => e.toMap()).toList(),
      'total': total,
      'requests': requests.map((e) => e.toMap()).toList(),
      'status': status,
      'isFeedback': isFeedback,
      'feedbackId': feedbackId,
      'technicianId': technicianId,
      'phoneNumberTechnician': phoneNumberTechnician
    };
  }
}
