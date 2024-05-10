import 'package:fusion_app_store/core/cloud_storage/keys.dart';

import 'models/app_review.dart';

class AppReviewEntity {
  final String appID;
  final List<AppReview> reviews;

  AppReviewEntity({required this.appID, required this.reviews});

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.appID: appID,
      StorageKeys.reviews: reviews.map((e) => e.toMap()),
    };
  }

  factory AppReviewEntity.fromMap(id, map) {
    if (map == null) {
      return AppReviewEntity(
        appID: id,
        reviews: [],
      );
    }
    return AppReviewEntity(
      appID: map[StorageKeys.appID],
      reviews: List<AppReview>.from(
          map[StorageKeys.reviews].map((e) => AppReview.fromMap(e))),
    );
  }
}
