import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class InAppPurchaseModel {
  final double min;
  final double max;
  final String currency;

  InAppPurchaseModel({
    required this.min,
    required this.max,
    this.currency = "Dollar (\$)",
  });

  static InAppPurchaseModel get empty => InAppPurchaseModel(
        min: 0,
        max: 0,
      );

  bool get isEmpty => min == 0 && max == 0;

  factory InAppPurchaseModel.fromMap(Map<String, dynamic> map) {
    return InAppPurchaseModel(
      min: map[StorageKeys.min].toDouble(),
      max: map[StorageKeys.max].toDouble(),
      currency: map[StorageKeys.currency],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.min: min,
      StorageKeys.max: max,
      StorageKeys.currency: currency,
    };
  }
}
