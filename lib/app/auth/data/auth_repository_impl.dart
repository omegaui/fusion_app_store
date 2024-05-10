import 'package:bcrypt/bcrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/core/cloud_storage/data_listener.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:get/get.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _provider = GoogleAuthProvider();

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> loginWithGoogle() async {
    final credentials = await _firebaseAuth.signInWithPopup(_provider);
    return credentials.credential != null;
  }

  @override
  Future<bool> loginWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final users =
        await Refs.users.where(StorageKeys.username, isEqualTo: username).get();
    if (users.docs.isEmpty) {
      return false;
    } else {
      final user = UserEntity.fromMap(map: users.docs[0].data());
      return BCrypt.checkpw(password, user.password);
    }
  }

  @override
  Future<bool> logout() async {
    await Get.find<DataListener>().closeConnection();
    await _firebaseAuth.signOut();
    return true;
  }

  @override
  Future<bool> isNewbie() async {
    final users = await Refs.users
        .where(StorageKeys.userLoginEmail,
            isEqualTo: _firebaseAuth.currentUser!.email!)
        .get();
    return users.docs.isEmpty;
  }
}
