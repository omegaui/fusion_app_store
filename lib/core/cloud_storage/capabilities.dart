import 'package:flutter/material.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';

extension MapCapabilities on Map {
  Map<String, dynamic> searchable() {
    final name = this[StorageKeys.name].toString().toLowerCase();
    final keys = <String>[];
    var current = "";
    for (final ch in name.characters) {
      current += ch;
      keys.add(current);
    }
    return {
      ...this,
      StorageKeys.search: keys,
    };
  }
}
