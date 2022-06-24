import 'package:technician_app/src/model/base_model.dart';

class SendNotification implements BaseModel {
  String title;
  String content;
  String badge;

  SendNotification(
      {required this.title, required this.content, required this.badge});
  @override
  Map<String, String> toMap() {
    return {'title': title, 'content': content, 'badge': badge};
  }
}
