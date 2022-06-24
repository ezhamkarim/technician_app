import 'package:firebase_messaging/firebase_messaging.dart';

class FcmMessageModel {
  int type;
  RemoteNotification message;

  FcmMessageModel(this.type, this.message);
}
