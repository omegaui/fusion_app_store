import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class AppReview {
  final String username;
  final DateTime when;
  final String message;
  final Reaction reaction;

  AppReview({
    required this.username,
    required this.when,
    required this.message,
    required this.reaction,
  });

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.username: username,
      StorageKeys.when: when.toString(),
      StorageKeys.message: message,
      StorageKeys.reaction: reaction.name,
    };
  }

  factory AppReview.fromMap(map) {
    return AppReview(
      username: map[StorageKeys.username],
      when: DateTime.parse(map[StorageKeys.when]),
      message: map[StorageKeys.message],
      reaction: Reaction.values.byName(map[StorageKeys.reaction]),
    );
  }
}
