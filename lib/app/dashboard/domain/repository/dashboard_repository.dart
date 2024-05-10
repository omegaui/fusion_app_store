import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

abstract class DashboardRepository {
  Future<Stream<UserEntity>> watchCurrentUser();

  Future<Stream<List<AppEntity>>> watchUserApps({required String maintainer});

  Future<Stream<List<AppEntity>>> watchLikedApps(
      {required List<String> appIDs});

  Future<Stream<List<AppEntity>>> watchReviewedApps(
      {required List<String> appIDs});

  Future<void> uploadApp({required AppEntity appEntity});

  Future<void> deleteApp({required AppEntity appEntity});
}
