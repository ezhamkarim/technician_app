import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/time_slot_model.dart';
import 'package:technician_app/src/services/database_service.dart';

class TimeSlotController extends DatabaseService {
  Future<void> create(TimeSlot timeSlot) async {
    try {
      var docRef = timeSlotCollection.doc();

      timeSlot.id = docRef.id;

      await docRef.set(timeSlot.toMap());
    } catch (e) {
      logError('Error create time slot');
      return;
    }
  }

  Stream<List<TimeSlot>> readForBooking(String date, String technicianId) {
    return timeSlotCollection
        .where('date', isEqualTo: date)
        .where('technicianId', isEqualTo: technicianId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => TimeSlot.fromSnapshot(e)).toList());
  }

  Future<void> update(TimeSlot timeSlot) async {
    try {
      await timeSlotCollection.doc(timeSlot.id).update(timeSlot.toMap());
    } catch (e) {
      logError('Error update time slot');
      return;
    }
  }
}
