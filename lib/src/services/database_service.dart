import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('usersTechnician');
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('bookingsTechnician');
  final CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('requestsTechnician');
  final CollectionReference servicesCollection =
      FirebaseFirestore.instance.collection('servicesTechnician');
}
