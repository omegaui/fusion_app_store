import 'package:fusion_app_store/core/cloud_storage/keys.dart';

enum PermissionType {
  location,
  storage,
  media,
  network,
  internet,
  wifi,
  microphone,
  camera,
  contacts,
  calendar,
  photos,
  sms,
  bluetooth,
  notification,
}

class Permission {
  final PermissionType type;
  List<String> description;

  Permission({
    required this.type,
    required this.description,
  });

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      type: PermissionType.values.byName(map[StorageKeys.type]),
      description: List<String>.from(map[StorageKeys.description]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.type: type.name,
      StorageKeys.description: description,
    };
  }
}

class Permissions {
  final List<Permission> permissions;

  Permissions({required this.permissions});

  static Permissions get empty => Permissions(permissions: []);

  factory Permissions.fromMap(Map<String, dynamic> map) {
    return Permissions(
      permissions: List<Permission>.from(
        map[StorageKeys.permissions].map((e) => Permission.fromMap(e)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.permissions: permissions.map((e) => e.toMap()).toList(),
    };
  }
}
