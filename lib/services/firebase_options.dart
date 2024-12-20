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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCE-Y0kqfUnlZcCJQCr52tDZCBHyfwFtjQ',
    appId: '1:1013785014771:web:6280873ae8da760008a286',
    messagingSenderId: '1013785014771',
    projectId: 'realty-group-project',
    authDomain: 'realty-group-project.firebaseapp.com',
    storageBucket: 'realty-group-project.firebasestorage.app',
    measurementId: 'G-J1L05C8J36',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJMKiXWue04t5keEXNDN_1OdHhk4apdFs',
    appId: '1:1013785014771:android:d76748235237eacc08a286',
    messagingSenderId: '1013785014771',
    projectId: 'realty-group-project',
    storageBucket: 'realty-group-project.firebasestorage.app',
  );

}