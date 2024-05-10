import 'package:fusion_app_store/app/analytics/domain/entities/app_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/app_downloads_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/app_reviews_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/basic_app_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/repository/analytics_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:get/get.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final _db = Get.find<FusionDatabase>();

  @override
  Future<void> increaseAppLikeCount(String id, String username) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final likeAnalytics = entity.likesAnalytics;
    final alreadyExists = likeAnalytics.any((e) => e.username == username);
    if (!alreadyExists) {
      likeAnalytics.add(
          BasicAppAnalyticsEntity(username: username, when: DateTime.now()));
    }
    await docRef.set(entity.toMap());
  }

  @override
  Future<void> decreaseAppLikeCount(String id, String username) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final likeAnalytics = entity.likesAnalytics;
    final object =
        likeAnalytics.firstWhereOrNull((e) => e.username == username);
    if (object != null) {
      likeAnalytics.remove(object);
    }
    await docRef.set(entity.toMap());
  }

  @override
  Future<void> increaseAppDownloadsCount(
    String id,
    PlatformType targetPlatform,
    String username,
  ) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final downloadsAnalytics = entity.downloadsAnalytics;
    downloadsAnalytics.add(AppDownloadsAnalyticsEntity(
        username: username,
        targetPlatform: targetPlatform,
        when: DateTime.now()));
    await docRef.set(entity.toMap());
  }

  @override
  Future<void> increaseAppReviewsCount(
    String id,
    Reaction reaction,
    String username,
  ) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final reviewsAnalytics = entity.reviewsAnalytics;
    reviewsAnalytics.add(AppReviewsAnalyticsEntity(
        username: username, reaction: reaction, when: DateTime.now()));
    await docRef.set(entity.toMap());
  }

  @override
  Future<void> increaseAppSharesCount(String id, String username) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final sharesAnalytics = entity.sharesAnalytics;
    sharesAnalytics
        .add(BasicAppAnalyticsEntity(username: username, when: DateTime.now()));
    await docRef.set(entity.toMap());
  }

  @override
  Future<void> increaseAppViewsCount(String id, [String? username]) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    final viewsAnalytics = entity.viewsAnalytics;
    if (username == null) {
      final user = await _db
          .getUserByEmail(GlobalFirebaseUtils.getCurrentUserLoginEmail());
      if (user != null) {
        username = user.username;
      }
    }
    viewsAnalytics.add(
        BasicAppAnalyticsEntity(username: username!, when: DateTime.now()));
    await docRef.set(entity.toMap());
  }

  @override
  Future<AppAnalyticsEntity> getAnalyticsData(String id) async {
    final docRef = Refs.appAnalytics.doc(id);
    final doc = await docRef.get();
    final entity = AppAnalyticsEntity.fromMap(id, doc.data());
    return entity;
  }
}
