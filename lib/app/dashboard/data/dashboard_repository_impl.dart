import 'dart:async';

import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/core/cloud_storage/data_listener.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/cloud_storage/storage.dart';
import 'package:fusion_app_store/core/global/page_control.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:get/get.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final _db = Get.find<FusionDatabase>();
  final _dataListener = Get.find<DataListener>();

  StreamSubscription? _currentUserStream;
  StreamSubscription? _currentUserAppsStream;
  StreamSubscription? _currentUserLikedAppsStream;
  StreamSubscription? _currentUserReviewedAppsStream;

  @override
  Future<Stream<UserEntity>> watchCurrentUser() async {
    final currentUserEmail = GlobalFirebaseUtils.getCurrentUserLoginEmail();
    if (_currentUserStream == null) {
      prettyLog(value: "Starting current user watcher for dashboard ...");
      final usersStream = Refs.users
          .where(StorageKeys.userLoginEmail, isEqualTo: currentUserEmail)
          .snapshots();
      _currentUserStream =
          _dataListener.listenUsers('ListenUser:DASHBOARD', usersStream);
    }
    final userStream = await _db.watchUserByEmail(currentUserEmail);
    return userStream;
  }

  @override
  Future<Stream<List<AppEntity>>> watchUserApps({
    required String maintainer,
  }) async {
    if (_currentUserAppsStream == null) {
      prettyLog(value: "Starting current user apps watcher for dashboard ...");
      final appsStream = Refs.apps
          .where(StorageKeys.maintainer, isEqualTo: maintainer)
          .snapshots();
      _currentUserAppsStream = _dataListener.listenApps(
          'ListenApps:DASHBOARD:OwnedApps', appsStream);
    }
    final userAppsStream = await _db.watchAppsByMaintainer(maintainer);
    return userAppsStream;
  }

  @override
  Future<Stream<List<AppEntity>>> watchLikedApps({
    required List<String> appIDs,
  }) async {
    if (appIDs.isNotEmpty) {
      if (_currentUserLikedAppsStream == null) {
        prettyLog(
            value:
                "Starting current user liked apps watcher for dashboard ...");
        final appsStream =
            Refs.apps.where(StorageKeys.packageID, whereIn: appIDs).snapshots();
        _currentUserLikedAppsStream = _dataListener.listenApps(
            'ListenApps:DASHBOARD:LikedApps', appsStream);
      }
    }
    final userAppsStream = await _db.watchApps(appIDs: appIDs);
    return userAppsStream;
  }

  @override
  Future<Stream<List<AppEntity>>> watchReviewedApps({
    required List<String> appIDs,
  }) async {
    if (appIDs.isNotEmpty) {
      if (_currentUserReviewedAppsStream == null) {
        prettyLog(
            value:
                "Starting current user reviewed apps watcher for dashboard ...");
        final appsStream =
            Refs.apps.where(StorageKeys.packageID, whereIn: appIDs).snapshots();
        _currentUserReviewedAppsStream = _dataListener.listenApps(
            'ListenApps:DASHBOARD:ReviewedApps', appsStream);
      }
    }
    final userAppsStream = await _db.watchApps(appIDs: appIDs);
    return userAppsStream;
  }

  @override
  Future<void> uploadApp({required AppEntity appEntity}) async {
    /// whenever a new app is uploaded
    /// it gets added to the [Headings.recentlyUpdatedApps] heading
    if (appEntity.publishedOn.isAtSameMomentAs(appEntity.updatedOn)) {
      appEntity.headings.add(Headings.recentlyAddedApps);
    } else {
      appEntity.headings.add(Headings.recentlyUpdatedApps);
      appEntity.headings.remove(Headings.recentlyAddedApps);
    }
    appEntity.pages.add('Home');
    await Refs.apps.doc(appEntity.appID).set(appEntity.toMap());
  }

  @override
  Future<void> deleteApp({required AppEntity appEntity}) async {
    await Refs.apps.doc(appEntity.appID).delete();
    // deleting icon, screenshots and bundles
    await Storage.deleteFolder(path: appEntity.storageBucketPath);
  }
}
