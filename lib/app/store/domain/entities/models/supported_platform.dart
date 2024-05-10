import 'package:flutter/foundation.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/version.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:get/get.dart';

enum PlatformType { windows, macos, linux, android, web }

class NativePlatformType {
  NativePlatformType._();

  static PlatformType identify(String canonicalName) {
    if (canonicalName.isEmpty) {
      return get();
    }
    const values = PlatformType.values;
    final result = values.firstWhereOrNull(
        (e) => e.name.isCaseInsensitiveContains(canonicalName));
    return result ?? get();
  }

  static PlatformType get() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return PlatformType.android;
      case TargetPlatform.linux:
        return PlatformType.linux;
      case TargetPlatform.macOS:
        return PlatformType.macos;
      case TargetPlatform.windows:
        return PlatformType.windows;
    }
  }
}

class SupportedPlatform {
  final PlatformType type;
  final List<String> os;
  final List<String> targetVersions;
  final List<String> dependencies;
  final List<Version> versions;

  SupportedPlatform({
    required this.type,
    required this.os,
    required this.targetVersions,
    required this.dependencies,
    required this.versions,
  });

  factory SupportedPlatform.fromMap(Map<String, dynamic> map) {
    return SupportedPlatform(
      type: PlatformType.values.byName(map[StorageKeys.type]),
      os: List<String>.from(map[StorageKeys.os]),
      targetVersions: List<String>.from(map[StorageKeys.targetVersions]),
      dependencies: List<String>.from(map[StorageKeys.dependencies]),
      versions: List<Version>.from(
        map[StorageKeys.versions]?.map((x) => Version.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.type: type.name,
      StorageKeys.os: os,
      StorageKeys.targetVersions: targetVersions,
      StorageKeys.dependencies: dependencies,
      StorageKeys.versions: versions.map((x) => x.toMap()).toList(),
    };
  }
}
