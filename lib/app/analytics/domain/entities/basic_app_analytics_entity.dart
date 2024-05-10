import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class BasicAppAnalyticsEntity {
  final String username;
  final DateTime when;

  BasicAppAnalyticsEntity({required this.username, required this.when});

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.username: username,
      StorageKeys.when: when.toString(),
    };
  }

  factory BasicAppAnalyticsEntity.fromMap(map) {
    return BasicAppAnalyticsEntity(
      username: map[StorageKeys.username],
      when: DateTime.parse(map[StorageKeys.when]),
    );
  }
}
