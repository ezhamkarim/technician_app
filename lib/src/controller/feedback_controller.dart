import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/feedback_model.dart';
import 'package:technician_app/src/services/database_service.dart';

import '../helper/log_helper.dart';

class FeedbackController extends DatabaseService {
  Future<void> create(Feedback feedback) async {
    try {
      var docRef = feedbackCollection.doc();
      feedback.id = docRef.id;
      await docRef.set(feedback.toMap());
    } catch (e) {
      logError('Error create booking: ${e.toString()}');
      return;
    }
  }

  Stream<List<Feedback>> read({String? query}) {
    return feedbackCollection
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      logInfo('This is the snapshot :${snapshot.docs.length}');
      return snapshot.docs.map((obj) => Feedback.fromSnapshot(obj)).toList();
    });
  }
}
