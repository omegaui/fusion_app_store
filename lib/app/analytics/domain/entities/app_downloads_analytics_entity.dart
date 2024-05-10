import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class AppDownloadsAnalyticsEntity {
  final String username;
  final PlatformType targetPlatform;
  final DateTime when;

  AppDownloadsAnalyticsEntity(
      {required this.username,
      required this.targetPlatform,
      required this.when});

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.username: username,
      StorageKeys.type: targetPlatform.name,
      StorageKeys.when: when.toString(),
    };
  }

  factory AppDownloadsAnalyticsEntity.fromMap(map) {
    return AppDownloadsAnalyticsEntity(
      username: map[StorageKeys.username],
      targetPlatform: PlatformType.values.byName(map[StorageKeys.type]),
      when: DateTime.parse(map[StorageKeys.when]),
    );
  }
}
