import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<String?> get getFirebaseToken async =>
      await firebaseMessaging.getToken();
}
