import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';

String getMaintainer(String id) {
  return id.substring(0, id.indexOf('-'));
}

String getPackageID(String id) {
  return id.substring(id.indexOf('-') + 1);
}

bool isLikedApp(UserEntity userEntity, AppEntity appEntity) {
  return userEntity.likedApps.contains(appEntity.appID);
}

List<String> getPlatformExecutableExtensions({required PlatformType type}) {
  switch (type) {
    case PlatformType.windows:
      return ['msi', 'exe'];
    case PlatformType.macos:
      return ['dmg'];
    case PlatformType.linux:
      return ['deb', 'rpm', 'gz', 'xz'];
    case PlatformType.android:
      return ['apk'];
    case PlatformType.web:
      return [];
  }
}

bool isAdmin() {
  return GlobalFirebaseUtils.getCurrentUserLoginEmail() ==
      'fusionpackagemanager@gmail.com';
}
