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
        return macos;
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
    apiKey: 'AIzaSyDrs5sAN3qmk9c8eR5o5JPrZwwek6qMZUQ',
    appId: '1:538092630030:web:2723a8d25aebeea0e8cc5f',
    messagingSenderId: '538092630030',
    projectId: 'learn-crud-auth',
    authDomain: 'learn-crud-auth.firebaseapp.com',
    storageBucket: 'learn-crud-auth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzFiFNCMvUE9pTNqV79oWn651MKhmziLE',
    appId: '1:538092630030:android:2572791364d81e63e8cc5f',
    messagingSenderId: '538092630030',
    projectId: 'learn-crud-auth',
    storageBucket: 'learn-crud-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvTbl0vqfdi--TqSP3ZUMyzZIZr-gkIvs',
    appId: '1:538092630030:ios:9cc6c29efdffa18fe8cc5f',
    messagingSenderId: '538092630030',
    projectId: 'learn-crud-auth',
    storageBucket: 'learn-crud-auth.appspot.com',
    iosClientId: '538092630030-hk0gquq6t13il79gq3fb3cfk8ukcbgm0.apps.googleusercontent.com',
    iosBundleId: 'com.example.learnFirebaseRiverpod',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvTbl0vqfdi--TqSP3ZUMyzZIZr-gkIvs',
    appId: '1:538092630030:ios:9cc6c29efdffa18fe8cc5f',
    messagingSenderId: '538092630030',
    projectId: 'learn-crud-auth',
    storageBucket: 'learn-crud-auth.appspot.com',
    iosClientId: '538092630030-hk0gquq6t13il79gq3fb3cfk8ukcbgm0.apps.googleusercontent.com',
    iosBundleId: 'com.example.learnFirebaseRiverpod',
  );
}
