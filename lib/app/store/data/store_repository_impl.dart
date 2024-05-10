import 'dart:async';

import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';
import 'package:fusion_app_store/constants/store_pages.dart';
import 'package:fusion_app_store/core/cloud_storage/data_listener.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/global/analytics_service.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:get/get.dart';

class StoreRepositoryImpl extends StoreRepository {
  final _db = Get.find<FusionDatabase>();
  final _dataListener = Get.find<DataListener>();

  final homePageAppIDs = <String>[];

  @override
  Future<UserEntity?> getCurrentUser() async {
    final currentUserLoginEmail =
        GlobalFirebaseUtils.getCurrentUserLoginEmail();
    final user = await _db.getUserByEmail(currentUserLoginEmail);
    if (user == null) {
      // fetching the current user
      // and, adding it to the fusion database
      final userDocument = await Refs.users
          .where(StorageKeys.userLoginEmail, isEqualTo: currentUserLoginEmail)
          .get();
      if (userDocument.docs.isNotEmpty) {
        final userMap = userDocument.docs.first.data();
        final userEntity = UserEntity.fromMap(map: userMap);
        await _db.addUsers([userEntity]);
        return userEntity;
      }
    }
    return user;
  }

  @override
  Future<void> watchUsers() async {
    final usersStream = Refs.users.snapshots();
    _dataListener.listenUsers('ListenUsers:STORE', usersStream);
  }

  @override
  Future<void> watchHomePageApps() async {
    final homePageStream = Refs.apps
        .where(StorageKeys.pages, arrayContains: StorePages.home)
        .snapshots();
    _dataListener.listenApps('ListenApps:HOME', homePageStream);
  }

  @override
  Future<Stream<List<AppEntity>>> getAppsByPage({required String page}) async {
    return await _db.watchAppsByPage(page: page);
  }

  @override
  Future<Stream<AppEntity?>> getAppByID({required String appID}) async {
    // checking if the app exists in firebase
    final appDocs =
        await Refs.apps.where(StorageKeys.appID, isEqualTo: appID).get();
    if (appDocs.docs.isNotEmpty) {
      final appStream =
          Refs.apps.where(StorageKeys.appID, arrayContains: appID).snapshots();
      _dataListener.listenApps('ListenApp:$appID', appStream);
      return await _db.watchApp(appID: appID);
    } else {
      // passing an arbitrary stream with empty app entity
      StreamController<AppEntity?> controller = StreamController();
      controller.add(AppEntity.empty(maintainer: '', packageID: ''));
      controller.close();
      return controller.stream;
    }
  }

  @override
  Future<Stream<AppReviewEntity>> getAppReviewsByID({
    required String appID,
  }) async {
    final appReviewsStream =
        Refs.appReviews.where(StorageKeys.appID, isEqualTo: appID).snapshots();
    _dataListener.listenAppReviews('ListenAppReviews:$appID', appReviewsStream);
    return await _db.watchAppReviews(appID: appID);
  }

  @override
  Future<void> likeApp({required AppEntity appEntity}) async {
    final currentUserLoginEmail =
        GlobalFirebaseUtils.getCurrentUserLoginEmail();
    final user = await _db.getUserByEmail(currentUserLoginEmail);
    if (user != null) {
      user.likedApps.add(appEntity.appID);
      await Refs.users.doc(user.username).update(user.toMap());
      await AnalyticsService.repository
          .increaseAppLikeCount(appEntity.appID, user.username);
    }
  }

  @override
  Future<void> dislikeApp({required AppEntity appEntity}) async {
    final currentUserLoginEmail =
        GlobalFirebaseUtils.getCurrentUserLoginEmail();
    final user = await _db.getUserByEmail(currentUserLoginEmail);
    if (user != null) {
      user.likedApps.remove(appEntity.appID);
      await Refs.users.doc(user.username).update(user.toMap());
      await AnalyticsService.repository
          .decreaseAppLikeCount(appEntity.appID, user.username);
    }
  }

  @override
  Future<void> reviewApp({
    required AppEntity appEntity,
    required AppReview appReview,
  }) async {
    final docRef = Refs.appReviews.doc(appEntity.appID);
    final doc = await docRef.get();
    final entity = AppReviewEntity.fromMap(appEntity.appID, doc.data());
    entity.reviews.add(appReview);
    await docRef.set(entity.toMap());

    // adding entry to user
    final currentUserLoginEmail =
        GlobalFirebaseUtils.getCurrentUserLoginEmail();
    final user = await _db.getUserByEmail(currentUserLoginEmail);
    if (user != null) {
      user.reviewedApps.add(appEntity.appID);
      await Refs.users.doc(user.username).update(user.toMap());
      await AnalyticsService.repository.increaseAppReviewsCount(
          appEntity.appID, appReview.reaction, user.username);
    }
  }

  @override
  Future<List<AppEntity>> getLocalApps() async {
    return await _db.getAllApps();
  }

  @override
  Future<UserEntity?> findUser({required String id}) async {
    final users = await _db.getUsers([id]);
    if (users.isEmpty) {
      final docRef = Refs.users.where(StorageKeys.username, isEqualTo: id);
      final doc = await docRef.get();
      if (doc.docs.isNotEmpty) {
        final userMap = doc.docs.first.data();
        final userEntity = UserEntity.fromMap(map: userMap);
        await _db.addUsers([userEntity]);
        return userEntity;
      } else {
        return null;
      }
    }
    return users.first;
  }

  @override
  Future<List<AppEntity>> getAppsByUser({
    required UserEntity userEntity,
  }) async {
    List<AppEntity> apps = [];
    final appDocs = await Refs.apps
        .where(StorageKeys.maintainer, isEqualTo: userEntity.username)
        .get();
    for (final app in appDocs.docs) {
      apps.add(AppEntity.fromMap(app.data()));
    }
    await _db.addApps(apps);
    return apps;
  }

  @override
  Future<void> verifyApp({required AppEntity appEntity}) async {
    appEntity = AppEntity.clone(appEntity, verified: true);
    await Refs.apps.doc(appEntity.appID).update(appEntity.toMap());
    await _db.addApps([appEntity]);
  }
}
