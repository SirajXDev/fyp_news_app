// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBVw3TwN_bg8W7eJIh0bswNesYDp0aiNSE',
    appId: '1:1040779411483:web:c6cee91874d46063a978be',
    messagingSenderId: '1040779411483',
    projectId: 'news-app-3ebad',
    authDomain: 'news-app-3ebad.firebaseapp.com',
    storageBucket: 'news-app-3ebad.appspot.com',
    measurementId: 'G-MEZNNPH8BF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpBQ2kYKmrFDJCxE6AAgE_1hamq_si3-E',
    appId: '1:1040779411483:android:fc626a05adee1272a978be',
    messagingSenderId: '1040779411483',
    projectId: 'news-app-3ebad',
    storageBucket: 'news-app-3ebad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDy0bH2CiNVLcsW5EVWW0hiZfOY8G6uiY',
    appId: '1:1040779411483:ios:4b21be4db4a377d7a978be',
    messagingSenderId: '1040779411483',
    projectId: 'news-app-3ebad',
    storageBucket: 'news-app-3ebad.appspot.com',
    iosBundleId: 'com.example.mewsApplication2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDy0bH2CiNVLcsW5EVWW0hiZfOY8G6uiY',
    appId: '1:1040779411483:ios:4b21be4db4a377d7a978be',
    messagingSenderId: '1040779411483',
    projectId: 'news-app-3ebad',
    storageBucket: 'news-app-3ebad.appspot.com',
    iosBundleId: 'com.example.mewsApplication2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVw3TwN_bg8W7eJIh0bswNesYDp0aiNSE',
    appId: '1:1040779411483:web:3c0105e8c252b260a978be',
    messagingSenderId: '1040779411483',
    projectId: 'news-app-3ebad',
    authDomain: 'news-app-3ebad.firebaseapp.com',
    storageBucket: 'news-app-3ebad.appspot.com',
    measurementId: 'G-F20XS5P2TQ',
  );
}