import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/services/database_service.dart';

import '../model/service_model.dart';

class ServiceController extends DatabaseService {
  Future<void> create(Service service) async {
    try {
      var docRef = servicesCollection.doc();

      service.id = docRef.id;

      await docRef.set(service.toMap());
    } catch (e) {
      logError('Error create service ${e.toString()}');
      return;
    }
  }

  Stream<List<Service>> read({String? query}) {
    return servicesCollection.snapshots().map((QuerySnapshot snapshot) {
      logInfo('This is the snapshot :${snapshot.docs.length}');
      return snapshot.docs.map((obj) => Service.fromSnapshot(obj)).toList();
    });
  }

  Future update(Service service) async {
    try {
      await servicesCollection.doc(service.id).update(service.toMap());
    } catch (e) {
      logError('Error update service ${e.toString()}');
      return;
    }
  }

  Future delete(Service service) async {
    try {
      await servicesCollection.doc(service.id).delete();
    } catch (e) {
      logError('Error delete service ${e.toString()}');
      return;
    }
  }
}
