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
    apiKey: 'AIzaSyBZ1C4-OlfZ9es8wI11n67Pfn6-2jO3_Sk',
    appId: '1:218216942084:web:8177f1e389af6825edc351',
    messagingSenderId: '218216942084',
    projectId: 'collegeevent-management-system',
    authDomain: 'collegeevent-management-system.firebaseapp.com',
    storageBucket: 'collegeevent-management-system.appspot.com',
    measurementId: 'G-4YKJ8CEXRH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0_JPXdOlPWpTe-GQQS4c3gvn4r_4c21o',
    appId: '1:218216942084:android:464598a87da25bd4edc351',
    messagingSenderId: '218216942084',
    projectId: 'collegeevent-management-system',
    storageBucket: 'collegeevent-management-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAn3oMLbrDdgGdB8zSMewWYp60JLXD2MhU',
    appId: '1:218216942084:ios:71966955233b94a4edc351',
    messagingSenderId: '218216942084',
    projectId: 'collegeevent-management-system',
    storageBucket: 'collegeevent-management-system.appspot.com',
    iosClientId: '218216942084-4mv7o4lhari0ili82netpgivfa9864lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.collegeEventManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAn3oMLbrDdgGdB8zSMewWYp60JLXD2MhU',
    appId: '1:218216942084:ios:132d70e0eebf235eedc351',
    messagingSenderId: '218216942084',
    projectId: 'collegeevent-management-system',
    storageBucket: 'collegeevent-management-system.appspot.com',
    iosClientId: '218216942084-g6abqna5ult931ub55r397pco3os6pg6.apps.googleusercontent.com',
    iosBundleId: 'com.example.collegeEventManagementSystem',
  );
}
