import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'DefaultFirebaseOptions have not been configured for macOS.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyC57gPRI48XT7R1qtggB60AqUbLYmDStLg",
    authDomain: "daily-planner-4a99c.firebaseapp.com",
    projectId: "daily-planner-4a99c",
    storageBucket: "daily-planner-4a99c.firebasestorage.app",
    messagingSenderId: "425200153710",
    appId: "1:425200153710:web:506c89518560272908627f",
    measurementId: "G-0S1VHE1TVC",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyC57gPRI48XT7R1qtggB60AqUbLYmDStLg",
    appId: "1:425200153710:web:506c89518560272908627f",
    messagingSenderId: "425200153710",
    projectId: "daily-planner-4a99c",
    storageBucket: "daily-planner-4a99c.firebasestorage.app",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCJyH6ZM9NH56soM6kD_dUd8n3UjEuR6yA",
    appId: "1:425200153710:ios:01fbeb97f0d88e8208627f",
    messagingSenderId: "425200153710",
    projectId: "daily-planner-4a99c",
    storageBucket: "daily-planner-4a99c.firebasestorage.app",
    iosClientId: "425200153710-s97s37e0eims5hmq6tkvhrkdm94aupo1.apps.googleusercontent.com",
    iosBundleId: "com.baseflow.permissionhandler.dailyPlanner",
  );
}
