import 'package:firebase_auth/firebase_auth.dart';

class GlobalFirebaseUtils {
  GlobalFirebaseUtils._();

  static final _firebaseAuth = FirebaseAuth.instance;

  static String getCurrentUserLoginEmail() {
    return _firebaseAuth.currentUser!.email!;
  }

  static String getCurrentUserGoogleAvatar() {
    return _firebaseAuth.currentUser!.photoURL!;
  }
}
