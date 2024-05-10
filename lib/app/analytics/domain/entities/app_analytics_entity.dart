import 'package:fusion_app_store/app/analytics/domain/entities/app_downloads_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/app_reviews_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/basic_app_analytics_entity.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class AppAnalyticsEntity {
  final String appID;
  final List<BasicAppAnalyticsEntity> likesAnalytics;
  final List<AppDownloadsAnalyticsEntity> downloadsAnalytics;
  final List<BasicAppAnalyticsEntity> viewsAnalytics;
  final List<AppReviewsAnalyticsEntity> reviewsAnalytics;
  final List<BasicAppAnalyticsEntity> sharesAnalytics;

  AppAnalyticsEntity({
    required this.appID,
    required this.likesAnalytics,
    required this.downloadsAnalytics,
    required this.viewsAnalytics,
    required this.reviewsAnalytics,
    required this.sharesAnalytics,
  });

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.appID: appID,
      StorageKeys.likeAnalytics: likesAnalytics.map((e) => e.toMap()),
      StorageKeys.downloadsAnalytics: downloadsAnalytics.map((e) => e.toMap()),
      StorageKeys.viewsAnalytics: viewsAnalytics.map((e) => e.toMap()),
      StorageKeys.reviewsAnalytics: reviewsAnalytics.map((e) => e.toMap()),
      StorageKeys.sharesAnalytics: sharesAnalytics.map((e) => e.toMap()),
    };
  }

  factory AppAnalyticsEntity.fromMap(id, map) {
    if (map == null) {
      return AppAnalyticsEntity.empty(id);
    }
    return AppAnalyticsEntity(
      appID: map[StorageKeys.appID],
      likesAnalytics: List<BasicAppAnalyticsEntity>.from(
          map[StorageKeys.likeAnalytics]
              .map((e) => BasicAppAnalyticsEntity.fromMap(e))),
      downloadsAnalytics: List<AppDownloadsAnalyticsEntity>.from(
          map[StorageKeys.downloadsAnalytics]
              .map((e) => AppDownloadsAnalyticsEntity.fromMap(e))),
      viewsAnalytics: List<BasicAppAnalyticsEntity>.from(
          map[StorageKeys.viewsAnalytics]
              .map((e) => BasicAppAnalyticsEntity.fromMap(e))),
      reviewsAnalytics: List<AppReviewsAnalyticsEntity>.from(
          map[StorageKeys.reviewsAnalytics]
              .map((e) => AppReviewsAnalyticsEntity.fromMap(e))),
      sharesAnalytics: List<BasicAppAnalyticsEntity>.from(
          map[StorageKeys.sharesAnalytics]
              .map((e) => BasicAppAnalyticsEntity.fromMap(e))),
    );
  }

  factory AppAnalyticsEntity.empty(appID) {
    return AppAnalyticsEntity(
      appID: appID,
      likesAnalytics: [],
      downloadsAnalytics: [],
      viewsAnalytics: [],
      reviewsAnalytics: [],
      sharesAnalytics: [],
    );
  }
}
