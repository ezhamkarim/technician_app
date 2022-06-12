import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('usersTechnician');
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('bookingsTechnician');
}
