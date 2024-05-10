import 'package:fusion_app_store/core/cloud_storage/keys.dart';

class Version {
  final String name;
  final bool enabled;
  final bool latest;
  final bool stable;
  final bool beta;
  String bundleUrl;
  final String downloadSize;

  Version({
    required this.name,
    required this.enabled,
    required this.latest,
    required this.stable,
    required this.beta,
    required this.bundleUrl,
    required this.downloadSize,
  });

  Version copyWith({
    String? name,
    bool? enabled,
    bool? latest,
    bool? stable,
    bool? beta,
    String? bundleUrl,
    String? downloadSize,
  }) {
    return Version(
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
      latest: latest ?? this.latest,
      stable: stable ?? this.stable,
      beta: beta ?? this.beta,
      bundleUrl: bundleUrl ?? this.bundleUrl,
      downloadSize: downloadSize ?? this.downloadSize,
    );
  }

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(
      name: map[StorageKeys.name],
      enabled: map[StorageKeys.enabled],
      latest: map[StorageKeys.latest],
      stable: map[StorageKeys.stable],
      beta: map[StorageKeys.beta],
      bundleUrl: map[StorageKeys.bundleUrl],
      downloadSize: map[StorageKeys.downloadSize],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.name: name,
      StorageKeys.enabled: enabled,
      StorageKeys.latest: latest,
      StorageKeys.stable: stable,
      StorageKeys.beta: beta,
      StorageKeys.bundleUrl: bundleUrl,
      StorageKeys.downloadSize: downloadSize,
    };
  }
}
