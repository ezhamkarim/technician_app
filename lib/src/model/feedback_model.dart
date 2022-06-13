import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/base_model.dart';

class Feedback implements BaseModel {
  String id;
  int rating;
  String comment;
  String userId;
  String techicianId;
  DateTime dateTime;
  Feedback(
      {required this.id,
      required this.comment,
      required this.rating,
      required this.techicianId,
      required this.userId,
      required this.dateTime});
  factory Feedback.fromObj(Map<String, dynamic> json) {
    return Feedback(
        comment: json['comment'],
        rating: json['rating'],
        techicianId: json['technicianId'],
        userId: json['userId'],
        dateTime: json['dateTime'].toDate(),
        id: json['id']);
  }

  factory Feedback.fromSnapshot(DocumentSnapshot documentSnapshot) {
    var json = documentSnapshot.data() as Map<String, dynamic>;
    logInfo('Json :$json');
    return Feedback(
        comment: json['comment'],
        rating: json['rating'],
        techicianId: json['technicianId'],
        userId: json['userId'],
        dateTime: json['dateTime'].toDate(),
        id: json['id']);
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comment,
      'technicianId': techicianId,
      'userId': userId,
      'dateTime': dateTime,
      'id': id
    };
  }
}
