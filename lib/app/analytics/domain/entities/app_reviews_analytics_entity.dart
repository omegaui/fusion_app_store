import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class AppReviewsAnalyticsEntity {
  final String username;
  final Reaction reaction;
  final DateTime when;

  AppReviewsAnalyticsEntity(
      {required this.username, required this.reaction, required this.when});

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.username: username,
      StorageKeys.type: reaction.name,
      StorageKeys.when: when.toString(),
    };
  }

  factory AppReviewsAnalyticsEntity.fromMap(map) {
    return AppReviewsAnalyticsEntity(
      username: map[StorageKeys.username],
      reaction: Reaction.values.byName(map[StorageKeys.type]),
      when: DateTime.parse(map[StorageKeys.when]),
    );
  }
}
