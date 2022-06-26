import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/send_notification_model.dart';

import '../model/fcm_model.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static ValueNotifier<FcmMessageModel?> fcmMessageModel =
      ValueNotifier<FcmMessageModel?>(null);
  static Future<String?> get getFirebaseToken async =>
      await _firebaseMessaging.getToken();

  static void listen() async {
    logInfo('Listening....');
    await getFirebaseToken;
    FirebaseMessaging.onMessage.listen((message) {
      logSuccess('on message ${message.notification?.title}');
      fcmMessageModel.value = FcmMessageModel(0, message);
    }, onError: (o, s) {
      logError('Error listening $o , $s');
    });
  }

  static Future<void> sendMessage(
      String pushTokenCustomer, SendNotification sendNotification) async {
    try {
      await _firebaseMessaging.sendMessage(
          to: pushTokenCustomer, data: sendNotification.toMap());
    } catch (e) {
      logError('Failed to send message ${e.toString()}');
    }
  }
}
