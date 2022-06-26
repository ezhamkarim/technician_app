import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:technician_app/src/helper/log_helper.dart';

class LocalNotification {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', "High Importance Notifcations",
      // "This channel is used important notification",
      groupId: "Notification_group");
  //* Setup singleton factory
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final LocalNotification _notificationService =
      LocalNotification._internal();

  factory LocalNotification() {
    print('Factory initialized');
    return _notificationService;
  }

  LocalNotification._internal();

  Future init() async {
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  //?Handle notification tapped
  static Future selectNotification(String? payload) async {
    if (payload == 'data') {
      //log('Hai awak tekan notification, ini datanya :$payload');
    }
  }

  //? Handle notification for iOS when tapped

  static Future onDidReceiveLocalNotification(
      int i, String? string1, String? string2, String? string3) async {
    //log('Message: $string1');
  }
  void showNotification(RemoteMessage messages) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'com.fyp.technician_app',
        'Technician App',
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      logSuccess('Show notification');
      await flutterLocalNotificationsPlugin
          .show(id, messages.notification!.title.toString(),
              messages.notification!.body.toString(), platformChannelSpecifics,
              payload: '')
          .then((value) => logSuccess('Show then'));
    } catch (e) {
      logError('Error show notification ${e.toString()}');
    }
  }
}
