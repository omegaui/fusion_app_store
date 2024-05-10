import 'package:cloud_firestore/cloud_firestore.dart';

class Refs {
  Refs._();

  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> users =
      _firestore.collection('users');

  static CollectionReference<Map<String, dynamic>> apps =
      _firestore.collection('apps');

  static CollectionReference<Map<String, dynamic>> appAnalytics =
      _firestore.collection('appAnalytics');

  static CollectionReference<Map<String, dynamic>> userAnalytics =
      _firestore.collection('userAnalytics');

  static CollectionReference<Map<String, dynamic>> appReviews =
      _firestore.collection('appReviews');

  static CollectionReference<Map<String, dynamic>> premiumUsers =
      _firestore.collection('premiumUsers');
}
