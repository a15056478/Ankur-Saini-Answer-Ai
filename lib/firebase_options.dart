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
    apiKey: 'AIzaSyCAcHkUQYDkfXSSrrm7R99ng2f63qJcq2A',
    appId: '1:103861998924:web:8f38bd1ab3087247d8ebe9',
    messagingSenderId: '103861998924',
    projectId: 'answers-ai',
    authDomain: 'answers-ai.firebaseapp.com',
    storageBucket: 'answers-ai.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBY3DGaWyqHW9ivLvUyPdHolHF0VrzayXY',
    appId: '1:103861998924:android:95b10b017bdd4cfed8ebe9',
    messagingSenderId: '103861998924',
    projectId: 'answers-ai',
    storageBucket: 'answers-ai.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxLMAwCCSJ5bxL3WmTC7Vyd8Vsal8lGEQ',
    appId: '1:103861998924:ios:56ecae1f7c23acbfd8ebe9',
    messagingSenderId: '103861998924',
    projectId: 'answers-ai',
    storageBucket: 'answers-ai.appspot.com',
    iosBundleId: 'com.example.answersAi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxLMAwCCSJ5bxL3WmTC7Vyd8Vsal8lGEQ',
    appId: '1:103861998924:ios:56ecae1f7c23acbfd8ebe9',
    messagingSenderId: '103861998924',
    projectId: 'answers-ai',
    storageBucket: 'answers-ai.appspot.com',
    iosBundleId: 'com.example.answersAi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAcHkUQYDkfXSSrrm7R99ng2f63qJcq2A',
    appId: '1:103861998924:web:cd51ae1af12128bbd8ebe9',
    messagingSenderId: '103861998924',
    projectId: 'answers-ai',
    authDomain: 'answers-ai.firebaseapp.com',
    storageBucket: 'answers-ai.appspot.com',
  );
}
