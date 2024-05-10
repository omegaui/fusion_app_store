import 'package:fusion_app_store/core/cloud_storage/keys.dart';

enum SystemRequirementsType {
  minimum,
  recommended,
}

class SystemRequirements {
  final SystemRequirementsType type;
  String ram;
  String cpu;
  String architecture;
  final Map<String, String> additional;

  SystemRequirements({
    required this.type,
    required this.ram,
    required this.cpu,
    required this.architecture,
    required this.additional,
  });

  factory SystemRequirements.fromMap(Map<String, dynamic> map) {
    return SystemRequirements(
      type: SystemRequirementsType.values.byName(map[StorageKeys.type]),
      ram: map[StorageKeys.ram],
      cpu: map[StorageKeys.cpu],
      architecture: map[StorageKeys.architecture],
      additional: Map<String, String>.from(map[StorageKeys.additional]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      StorageKeys.type: type.name,
      StorageKeys.ram: ram,
      StorageKeys.cpu: cpu,
      StorageKeys.architecture: architecture,
      StorageKeys.additional: additional,
    };
  }
}
