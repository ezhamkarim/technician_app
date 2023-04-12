// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7iE4Y3LxZem4v9FjbON7T9p-9O9uBtq4',
    appId: '1:761280440018:web:5e3a9417dd7d290362ef0b',
    messagingSenderId: '761280440018',
    projectId: 'signin-75855',
    authDomain: 'signin-75855.firebaseapp.com',
    databaseURL: 'https://signin-75855.firebaseio.com',
    storageBucket: 'signin-75855.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARoolIxeutppUXEPiZoeurKbjh5I3wrcc',
    appId: '1:761280440018:android:8dedfa0b4e505a6262ef0b',
    messagingSenderId: '761280440018',
    projectId: 'signin-75855',
    databaseURL: 'https://signin-75855.firebaseio.com',
    storageBucket: 'signin-75855.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN7mw2jx0vNGum26MXUxyB2VYWTN7UV3A',
    appId: '1:761280440018:ios:23ba2347d262555062ef0b',
    messagingSenderId: '761280440018',
    projectId: 'signin-75855',
    databaseURL: 'https://signin-75855.firebaseio.com',
    storageBucket: 'signin-75855.appspot.com',
    androidClientId: '761280440018-b5kqib90r3ure0h2kqij02m7ci1poh03.apps.googleusercontent.com',
    iosClientId: '761280440018-2ebc2nhqnha971m4ptfql4229st026ed.apps.googleusercontent.com',
    iosBundleId: 'com.fyp.technicianApp',
  );
}