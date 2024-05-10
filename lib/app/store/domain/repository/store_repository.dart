import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';

abstract class StoreRepository {
  Future<void> watchUsers();
  Future<void> watchHomePageApps();
  Future<UserEntity?> getCurrentUser();
  Future<Stream<List<AppEntity>>> getAppsByPage({required String page});
  Future<Stream<AppEntity?>> getAppByID({required String appID});
  Future<Stream<AppReviewEntity>> getAppReviewsByID({required String appID});
  Future<void> likeApp({required AppEntity appEntity});
  Future<void> dislikeApp({required AppEntity appEntity});
  Future<void> reviewApp(
      {required AppEntity appEntity, required AppReview appReview});
  Future<List<AppEntity>> getLocalApps();
  Future<UserEntity?> findUser({required String id});
  Future<List<AppEntity>> getAppsByUser({required UserEntity userEntity});
  Future<void> verifyApp({required AppEntity appEntity});
}
