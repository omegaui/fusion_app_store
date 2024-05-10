import 'package:fusion_app_store/app/analytics/domain/entities/app_analytics_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';

abstract class AnalyticsRepository {
  Future<void> increaseAppLikeCount(String id, String username);
  Future<void> decreaseAppLikeCount(String id, String username);
  Future<void> increaseAppViewsCount(String id, [String? username]);
  Future<void> increaseAppDownloadsCount(
      String id, PlatformType targetPlatform, String username);
  Future<void> increaseAppReviewsCount(
      String id, Reaction reaction, String username);
  Future<void> increaseAppSharesCount(String id, String username);

  Future<AppAnalyticsEntity> getAnalyticsData(String id);
}
