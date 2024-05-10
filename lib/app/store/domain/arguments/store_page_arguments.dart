import 'package:firebase_auth/firebase_auth.dart';

class StorePageArguments {
  late final bool isUserLoggedIn;
  final bool isOnBoarded;

  StorePageArguments({
    bool isUserLoggedIn = false,
    this.isOnBoarded = false,
  }) {
    this.isUserLoggedIn =
        isUserLoggedIn || FirebaseAuth.instance.currentUser != null;
  }
}
