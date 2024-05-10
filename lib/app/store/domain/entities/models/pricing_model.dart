import 'package:fusion_app_store/core/cloud_storage/keys.dart';

enum PricingType {
  paid,
  free,
}

class PricingModel {
  final PricingType type;
  final double price;
  final String currency;

  PricingModel({
    required this.type,
    required this.price,
    this.currency = "Dollar (\$)",
  });

  static PricingModel get empty => PricingModel(
        type: PricingType.free,
        price: 0,
      );

  factory PricingModel.fromMap(Map<String, dynamic> map) {
    return PricingModel(
      type: PricingType.values.byName(map[StorageKeys.type]),
      price: map[StorageKeys.price].toDouble(),
      currency: map[StorageKeys.currency],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.type: type.name,
      StorageKeys.price: price,
      StorageKeys.currency: currency,
    };
  }
}
