// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCy3CFDCLB2yZaj5VjakBgC_aahL5d6YnA',
    appId: '1:189689062891:web:57d1c4b1fbb1f1750165ae',
    messagingSenderId: '189689062891',
    projectId: 'fl2qwerty',
    authDomain: 'fl2qwerty.firebaseapp.com',
    databaseURL: 'https://fl2qwerty-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fl2qwerty.appspot.com',
    measurementId: 'G-7E9PR1CW1Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2f4dvPgNqg7SHtB4zIiKa9ZMK2emtnpM',
    appId: '1:189689062891:android:9bea4f934c19f8670165ae',
    messagingSenderId: '189689062891',
    projectId: 'fl2qwerty',
    databaseURL: 'https://fl2qwerty-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fl2qwerty.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-V1uStx1DFFSDFNjg5g4iyQDdeq2jNEY',
    appId: '1:189689062891:ios:bc9fef9d22e7be820165ae',
    messagingSenderId: '189689062891',
    projectId: 'fl2qwerty',
    databaseURL: 'https://fl2qwerty-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fl2qwerty.appspot.com',
    iosClientId: '189689062891-mf0bqvafmrrb9h0bqk4027b4hrfplcs1.apps.googleusercontent.com',
    iosBundleId: 'com.example.fl2Qwerty',
  );
}
