import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// This file configures Firebase options for different platforms.
/// 
/// IMPORTANT: You must configure Firebase in your Google Cloud Console and add your configuration here:
/// 1. Go to Firebase Console: https://console.firebase.google.com/
/// 2. Create a new project or use an existing one
/// 3. Enable Authentication (Email/Password and Anonymous)
/// 4. Create a Firestore database
/// 5. Get your Firebase config and update the values below
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyC8ymDIX-3jH7KLTOaa5a8koKeM_rmU5jc",
    authDomain: "fir-simplechatapp-5745a.firebaseapp.com",
    projectId: "fir-simplechatapp-5745a",
    storageBucket: "fir-simplechatapp-5745a.firebasestorage.app",
    messagingSenderId: "782743475584",
    appId: "1:782743475584:web:796db471d323748c209d65",
    measurementId: "G-CBSHX50EWW"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHaAMwlwrvu0H_N5hyy15MdzX0vj61Fwc',
    appId: '1:782743475584:android:74d0c6e6b13aa5d7209d65',
    messagingSenderId: '782743475584',
    projectId: 'fir-simplechatapp-5745a',
  );

}
