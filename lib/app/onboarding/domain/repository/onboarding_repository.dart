import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';

abstract class OnBoardingRepository {
  Future<void> updateUser({required UserEntity userEntity});
  Future<bool> isUsernameAvailable({required String username});
}
