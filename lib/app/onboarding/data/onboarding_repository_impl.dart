import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/domain/repository/onboarding_repository.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';

class OnBoardingRepositoryImpl extends OnBoardingRepository {
  @override
  Future<void> updateUser({required UserEntity userEntity}) async {
    await Refs.users.doc(userEntity.username).set(userEntity.toMap());
  }

  @override
  Future<bool> isUsernameAvailable({required String username}) async {
    final users =
        await Refs.users.where(StorageKeys.username, isEqualTo: username).get();
    return users.docs.isEmpty;
  }
}
