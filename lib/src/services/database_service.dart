import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('bookings');
}
