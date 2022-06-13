import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/enum/view_state.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/database_service.dart';

class BookingController extends DatabaseService {
  final String? id;
  BookingController({this.id});

  Future<void> create(Booking booking, RootProvider rootProvider) async {
    try {
      rootProvider.setState = ViewState.busy;
      var docRef = bookingCollection.doc();
      booking.id = docRef.id;
      await docRef.set(booking.toMap());
      rootProvider.setState = ViewState.idle;
    } catch (e) {
      logError('Error create booking: ${e.toString()}');
      rootProvider.setState = ViewState.idle;
      return;
    }
  }

  Stream<List<Booking>> read({String? query}) {
    return bookingCollection
        .where('technicianId', isEqualTo: query)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      logInfo('This is the snapshot :${snapshot.docs.length}');
      return snapshot.docs.map((obj) => Booking.fromSnapshot(obj)).toList();
    });
  }

  Future<void> update(Booking booking, RootProvider rootProvider) async {
    try {
      rootProvider.setState = ViewState.busy;
      await bookingCollection.doc(booking.id).update(booking.toMap());
      rootProvider.setState = ViewState.idle;
    } catch (e) {
      logError('Error create booking: ${e.toString()}');
      rootProvider.setState = ViewState.idle;
      return;
    }
  }
}
