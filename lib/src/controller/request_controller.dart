import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/model/request_model.dart';
import 'package:technician_app/src/services/database_service.dart';

import '../helper/log_helper.dart';

class RequestController extends DatabaseService {
  Future<void> create(Request request) async {
    try {
      var docRef = requestCollection.doc();

      request.id = docRef.id;

      await docRef.set(request.toMap());
    } catch (e) {
      logError('Error create request ${e.toString()}');
      return;
    }
  }

  Stream<List<Request>> read({String? query}) {
    return servicesCollection.snapshots().map((QuerySnapshot snapshot) {
      logInfo('This is the snapshot :${snapshot.docs.length}');
      return snapshot.docs.map((obj) => Request.fromSnapshot(obj)).toList();
    });
  }
}
