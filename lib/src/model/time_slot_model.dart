import 'package:technician_app/src/model/base_model.dart';

class TimeSlot implements BaseModel {
  String techicianId;
  List<Slot> slots;

  TimeSlot({required this.techicianId, required this.slots});

  factory TimeSlot.fromObj(Map<String, dynamic> obj) {
    return TimeSlot(techicianId: obj['techicianId'], slots: obj['slots']);
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'techicianId': techicianId,
      'slots': slots.map((e) => e.toMap()).toList()
    };
  }
}

class Slot implements BaseModel {
  String time;
  String isActive;

  factory Slot.fromObj(Map<String, dynamic> obj) {
    return Slot(time: obj['time'], isActive: obj['isActive']);
  }
  Slot({required this.time, required this.isActive});

  @override
  Map<String, dynamic> toMap() {
    return {'time': time, 'isActive': isActive};
  }
}
