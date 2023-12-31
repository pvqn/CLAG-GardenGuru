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
    apiKey: 'AIzaSyDlONdJXYaFm2wXHR-S5U3h7pJRyM7LyQE',
    appId: '1:855134274675:web:9a79a1b3a31406632f5606',
    messagingSenderId: '855134274675',
    projectId: 'gardenguru-36f81',
    authDomain: 'gardenguru-36f81.firebaseapp.com',
    databaseURL: 'https://gardenguru-36f81-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gardenguru-36f81.appspot.com',
    measurementId: 'G-MVRD6LVGN0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC137hl9eelwnbXd94OF_RO2SuyoobL3dw',
    appId: '1:855134274675:android:b3a5c956fd2a2e732f5606',
    messagingSenderId: '855134274675',
    projectId: 'gardenguru-36f81',
    databaseURL: 'https://gardenguru-36f81-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gardenguru-36f81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd7IP_MzfUY0pC8In98czd5OTEk4vsDDA',
    appId: '1:855134274675:ios:bf1bc66fb2c8f0cc2f5606',
    messagingSenderId: '855134274675',
    projectId: 'gardenguru-36f81',
    databaseURL: 'https://gardenguru-36f81-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gardenguru-36f81.appspot.com',
    iosBundleId: 'com.example.gardenguru',
  );
}
