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
    apiKey: 'AIzaSyCAZSAEQWRMMTLHTl2lOMlbC2TSgNe8GGM',
    appId: '1:1001153036141:web:7f26e2b73f645601746464',
    messagingSenderId: '1001153036141',
    projectId: 'chat-app-d3b52',
    authDomain: 'chat-app-d3b52.firebaseapp.com',
    storageBucket: 'chat-app-d3b52.appspot.com',
    measurementId: 'G-9V99Y9EGBN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCO-Lns3G6cGNkFNz_xytmi85ZmjEH4ftI',
    appId: '1:1001153036141:android:65eae8d819c96e61746464',
    messagingSenderId: '1001153036141',
    projectId: 'chat-app-d3b52',
    storageBucket: 'chat-app-d3b52.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtrq31uUQc5DKiHOZLEjwHNaX7Tp0CW3w',
    appId: '1:1001153036141:ios:c6660165b603a572746464',
    messagingSenderId: '1001153036141',
    projectId: 'chat-app-d3b52',
    storageBucket: 'chat-app-d3b52.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
