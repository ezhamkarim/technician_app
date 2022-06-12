import 'package:technician_app/src/model/base_model.dart';

class Feedback implements BaseModel {
  int rating;
  String comment;

  Feedback({required this.comment, required this.rating});
  factory Feedback.fromObj(Map<String, dynamic> json) {
    return Feedback(comment: json['comment'], rating: json['rating']);
  }
  @override
  Map<String, dynamic> toMap() {
    return {'rating': rating, 'comment': comment};
  }
}
