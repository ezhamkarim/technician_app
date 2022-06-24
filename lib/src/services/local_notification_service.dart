import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
        AndroidInitializationSettings('ic_spr');

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
  void showNotification(RemoteNotification messages) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'com.duytq.flutterchatdemo',
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

    await flutterLocalNotificationsPlugin.show(
      0,
      messages.title.toString(),
      messages.body.toString(),
      platformChannelSpecifics,
    );
  }
}
