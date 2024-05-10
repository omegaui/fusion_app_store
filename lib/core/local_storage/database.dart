/*
 * To rebuild the database run ...
 * dart run build_runner build
 */

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/esrb_rating.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/in_app_purchase_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/permissions.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/pricing_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/system_requirements.dart';
import 'package:fusion_app_store/constants/user_type.dart';
import 'package:fusion_app_store/core/local_storage/tables/app_review_table.dart';
import 'package:fusion_app_store/core/local_storage/tables/app_table.dart';
import 'package:fusion_app_store/core/local_storage/tables/user_table.dart';
import 'package:fusion_app_store/core/logging/logger.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [UserTable, AppTable, AppReviewTable],
  queries: {
    '_getUsers': 'select * from user_table',
    '_getUserByUsername': 'select * from user_table where username = ?',
    '_getUserByEmail': 'select * from user_table where user_login_email = ?',
    '_deleteUserByUsername': 'delete from user_table where username = ?',
    '_getApps': 'select * from app_table',
    '_getAppsByMaintainer':
        'select * from app_table where maintainer = ? order by updated_on desc',
    '_getAppsByPages':
        'select * from app_table where pages like ? order by updated_on desc',
    '_getApp': 'select * from app_table where app_i_d = ?',
    '_deleteAppByAppID': 'delete from app_table where app_i_d = ?',
    '_getAppReviews': 'select * from app_review_table where app_i_d = ?',
  },
)
class FusionDatabase extends _$FusionDatabase {
  FusionDatabase(super.e);

  @override
  int get schemaVersion => 1;

  static FusionDatabase getInstance() {
    return FusionDatabase(connectOnWeb());
  }

  /// a function to add the [UserEntity] objects into the [UserTable]
  Future<void> addUsers(List<UserEntity> users) async {
    debugPrint("[Database] Adding ${users.length} UserEntity objects ...");
    await batch((batch) {
      batch.insertAll(
        userTable,
        users.map((user) {
          return UserTableCompanion.insert(
            username: user.username,
            userLoginEmail: user.userLoginEmail,
            password: user.password,
            avatarUrl: user.avatarUrl,
            bio: user.bio,
            address: user.address,
            website: user.website,
            privacyPolicy: user.privacyPolicy,
            termsAndConditions: user.termsAndConditions,
            userType: user.userType.name,
            likedApps: jsonEncode(user.likedApps.toList()),
            ownedApps: jsonEncode(user.ownedApps.toList()),
            reviewedApps: jsonEncode(user.reviewedApps.toList()),
            active: user.active,
            reputation: user.reputation,
            strikes: user.strikes,
            joinedAt: user.joinedAt,
          );
        }),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// a function to remove the [UserEntity] object from the [UserTable]
  Future<void> deleteUser(String username) async {
    await _deleteUserByUsername(username);
  }

  Future<List<String>> filterAbsentUsers(List<String> usernames) async {
    final presentUsers = await _getUsers().get();
    final presentUserNames = presentUsers.map((e) => e.username);
    usernames.removeWhere((e) => presentUserNames.contains(e));
    return usernames;
  }

  Future<List<UserEntity>> getUsers(List<String> usernames) async {
    final allUsers = await _getUsers().get();
    final filteredUserData =
        allUsers.where((e) => usernames.contains(e.username));
    final users = <UserEntity>[];
    for (final element in filteredUserData) {
      users.add(UserEntity(
        username: element.username,
        userLoginEmail: element.userLoginEmail,
        password: element.password,
        avatarUrl: element.avatarUrl,
        bio: element.bio,
        address: element.address,
        website: element.website,
        privacyPolicy: element.privacyPolicy,
        termsAndConditions: element.termsAndConditions,
        userType: UserType.values.byName(element.userType),
        ownedApps: Set<String>.from(jsonDecode(element.ownedApps)),
        likedApps: Set<String>.from(jsonDecode(element.likedApps)),
        reviewedApps: Set<String>.from(jsonDecode(element.reviewedApps)),
        active: element.active,
        reputation: element.reputation,
        strikes: element.strikes,
        joinedAt: element.joinedAt,
      ));
    }
    return users;
  }

  /// a function to watch a [UserEntity] for changes
  Future<Stream<UserEntity>> watchUserByUsername(String username) async {
    final user = _getUserByUsername(username).watch();
    final controller = StreamController<UserEntity>();
    user.listen((users) {
      if (users.isNotEmpty) {
        final element = users.first;
        controller.add(UserEntity(
          username: element.username,
          userLoginEmail: element.userLoginEmail,
          password: element.password,
          avatarUrl: element.avatarUrl,
          bio: element.bio,
          address: element.address,
          website: element.website,
          privacyPolicy: element.privacyPolicy,
          termsAndConditions: element.termsAndConditions,
          userType: UserType.values.byName(element.userType),
          ownedApps: Set<String>.from(jsonDecode(element.ownedApps)),
          likedApps: Set<String>.from(jsonDecode(element.likedApps)),
          reviewedApps: Set<String>.from(jsonDecode(element.reviewedApps)),
          active: element.active,
          reputation: element.reputation,
          strikes: element.strikes,
          joinedAt: element.joinedAt,
        ));
      } else {
        notifyNullEvent("watchUserByUsername", username);
      }
    });
    return controller.stream;
  }

  /// a function to watch a [UserEntity] for changes
  Future<Stream<UserEntity>> watchUserByEmail(String email) async {
    final user = _getUserByEmail(email).watch();
    final controller = StreamController<UserEntity>();
    user.listen((users) {
      final element = users.first;
      controller.add(UserEntity(
        username: element.username,
        userLoginEmail: element.userLoginEmail,
        password: element.password,
        avatarUrl: element.avatarUrl,
        bio: element.bio,
        address: element.address,
        website: element.website,
        privacyPolicy: element.privacyPolicy,
        termsAndConditions: element.termsAndConditions,
        userType: UserType.values.byName(element.userType),
        ownedApps: Set<String>.from(jsonDecode(element.ownedApps)),
        likedApps: Set<String>.from(jsonDecode(element.likedApps)),
        reviewedApps: Set<String>.from(jsonDecode(element.reviewedApps)),
        active: element.active,
        reputation: element.reputation,
        strikes: element.strikes,
        joinedAt: element.joinedAt,
      ));
    });
    return controller.stream;
  }

  /// a function to watch a [UserEntity] for changes
  Future<UserEntity?> getUserByEmail(String email) async {
    final users = await _getUserByEmail(email).get();
    if (users.isNotEmpty) {
      final element = users.first;
      return UserEntity(
        username: element.username,
        userLoginEmail: element.userLoginEmail,
        password: element.password,
        avatarUrl: element.avatarUrl,
        bio: element.bio,
        address: element.address,
        website: element.website,
        privacyPolicy: element.privacyPolicy,
        termsAndConditions: element.termsAndConditions,
        userType: UserType.values.byName(element.userType),
        ownedApps: Set<String>.from(jsonDecode(element.ownedApps)),
        likedApps: Set<String>.from(jsonDecode(element.likedApps)),
        reviewedApps: Set<String>.from(jsonDecode(element.reviewedApps)),
        active: element.active,
        reputation: element.reputation,
        strikes: element.strikes,
        joinedAt: element.joinedAt,
      );
    }
    return null;
  }

  /// a function to add the [AppEntity] objects into the [AppTable]
  Future<void> addApps(List<AppEntity> apps) async {
    debugPrint("[Database] Adding ${apps.length} AppEntity objects ...");
    await batch((batch) {
      batch.insertAll(
        appTable,
        apps.map((app) {
          return AppTableCompanion.insert(
            appID: app.appID,
            maintainer: app.maintainer,
            packageID: app.packageID,
            pages: jsonEncode(app.pages.toList()),
            headings: jsonEncode(app.headings.toList()),
            name: app.name,
        verified: app.verified,
            shortDescription: app.shortDescription,
            description: jsonEncode(app.description),
            tags: jsonEncode(app.tags),
            icon: app.icon,
            bannerImage: app.bannerImage,
            imageUrls: jsonEncode(app.imageUrls),
            category: app.category.name,
            esrbRating: app.esrbRating.name,
            pricingModel: jsonEncode(app.pricingModel.toMap()),
            inAppPurchaseModel: jsonEncode(app.inAppPurchaseModel.toMap()),
            forceLatest: app.forceLatest,
            systemRequirements: jsonEncode(List<Map<String, dynamic>>.from(
                app.systemRequirements.map((e) => e.toMap()))),
            permissions: jsonEncode(app.permissions.toMap()),
            supportedLanguages: jsonEncode(app.supportedLanguages),
            supportedPlatforms: jsonEncode(List<Map<String, dynamic>>.from(
                app.supportedPlatforms.map((e) => e.toMap()))),
            codeSource: app.codeSource,
            homepage: app.homepage,
            supportEmail: app.supportEmail,
            license: app.license,
            links: jsonEncode(app.links),
            publishedOn: app.publishedOn,
            updatedOn: app.updatedOn,
          );
        }),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// a function to remove the [AppEntity] objects into the [AppTable]
  Future<void> deleteApps(List<String> appIDs) async {
    debugPrint("[Database] Deleting ${appIDs.length} AppEntity objects ...");
    await batch((batch) {
      batch.deleteWhere(
        appTable,
        (app) => app.appID.isIn(appIDs),
      );
    });
  }

  /// a function to remove the [AppEntity] object from the [AppTable]
  Future<void> deleteApp(String appID) async {
    await _deleteAppByAppID(appID);
  }

  Future<List<String>> filterAbsentApps(List<String> appIDs) async {
    final presentApps = await _getApps().get();
    final presentAppIDs = presentApps.map((e) => e.appID);
    appIDs.removeWhere((e) => presentAppIDs.contains(e));
    return appIDs;
  }

  Future<List<AppEntity>> getApps(List<String> appIDs) async {
    final allApps = await _getApps().get();
    final filteredUserData = allApps.where((e) => appIDs.contains(e.appID));
    final apps = <AppEntity>[];
    for (final app in filteredUserData) {
      apps.add(AppEntity(
        appID: app.appID,
        maintainer: app.maintainer,
        packageID: app.packageID,
        name: app.name,
        verified: app.verified,
        pages: Set<String>.from(jsonDecode(app.pages)),
        headings: Set<String>.from(jsonDecode(app.headings)),
        shortDescription: app.shortDescription,
        description: List<String>.from(
            jsonDecode(app.description).map((e) => e.toString())),
        tags: List<String>.from(jsonDecode(app.tags).map((e) => e.toString())),
        icon: app.icon,
        bannerImage: app.bannerImage,
        imageUrls: List<String>.from(
            jsonDecode(app.imageUrls).map((e) => e.toString())),
        category: AppCategory.values.byName(app.category),
        esrbRating: EsrbRating.values.byName(app.esrbRating),
        pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
        inAppPurchaseModel:
            InAppPurchaseModel.fromMap(jsonDecode(app.inAppPurchaseModel)),
        forceLatest: app.forceLatest,
        systemRequirements: List<SystemRequirements>.from(
            jsonDecode(app.systemRequirements)
                .map((e) => SystemRequirements.fromMap(e))),
        permissions: Permissions.fromMap(jsonDecode(app.permissions)),
        supportedLanguages:
            List<String>.from(jsonDecode(app.supportedLanguages)),
        supportedPlatforms: List<SupportedPlatform>.from(
            jsonDecode(app.supportedPlatforms)
                .map((e) => SupportedPlatform.fromMap(e))),
        codeSource: app.codeSource,
        homepage: app.homepage,
        supportEmail: app.supportEmail,
        license: app.license,
        links: List<String>.from(jsonDecode(app.links)),
        publishedOn: app.publishedOn,
        updatedOn: app.updatedOn,
      ));
    }
    return apps;
  }

  Future<List<AppEntity>> getAllApps() async {
    final allApps = await _getApps().get();
    final apps = <AppEntity>[];
    for (final app in allApps) {
      apps.add(AppEntity(
        appID: app.appID,
        maintainer: app.maintainer,
        packageID: app.packageID,
        name: app.name,
        verified: app.verified,
        pages: Set<String>.from(jsonDecode(app.pages)),
        headings: Set<String>.from(jsonDecode(app.headings)),
        shortDescription: app.shortDescription,
        description: List<String>.from(
            jsonDecode(app.description).map((e) => e.toString())),
        tags: List<String>.from(jsonDecode(app.tags).map((e) => e.toString())),
        icon: app.icon,
        bannerImage: app.bannerImage,
        imageUrls: List<String>.from(
            jsonDecode(app.imageUrls).map((e) => e.toString())),
        category: AppCategory.values.byName(app.category),
        esrbRating: EsrbRating.values.byName(app.esrbRating),
        pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
        inAppPurchaseModel:
            InAppPurchaseModel.fromMap(jsonDecode(app.inAppPurchaseModel)),
        forceLatest: app.forceLatest,
        systemRequirements: List<SystemRequirements>.from(
            jsonDecode(app.systemRequirements)
                .map((e) => SystemRequirements.fromMap(e))),
        permissions: Permissions.fromMap(jsonDecode(app.permissions)),
        supportedLanguages:
            List<String>.from(jsonDecode(app.supportedLanguages)),
        supportedPlatforms: List<SupportedPlatform>.from(
            jsonDecode(app.supportedPlatforms)
                .map((e) => SupportedPlatform.fromMap(e))),
        codeSource: app.codeSource,
        homepage: app.homepage,
        supportEmail: app.supportEmail,
        license: app.license,
        links: List<String>.from(jsonDecode(app.links)),
        publishedOn: app.publishedOn,
        updatedOn: app.updatedOn,
      ));
    }
    return apps;
  }

  /// a function to fetch all user [AppEntity] objects from the [AppTable]
  Future<Stream<List<AppEntity>>> watchAppsByMaintainer(
      String maintainer) async {
    final appsStream = _getAppsByMaintainer(maintainer).watch();
    final controller = StreamController<List<AppEntity>>();
    appsStream.listen((apps) {
      final userApps = <AppEntity>[];
      if (apps.isNotEmpty) {
        for (final app in apps) {
          userApps.add(
            AppEntity(
              appID: app.appID,
              maintainer: app.maintainer,
              packageID: app.packageID,
              name: app.name,
        verified: app.verified,
              pages: Set<String>.from(jsonDecode(app.pages)),
              headings: Set<String>.from(jsonDecode(app.headings)),
              shortDescription: app.shortDescription,
              description: List<String>.from(
                  jsonDecode(app.description).map((e) => e.toString())),
              tags: List<String>.from(
                  jsonDecode(app.tags).map((e) => e.toString())),
              icon: app.icon,
              bannerImage: app.bannerImage,
              imageUrls: List<String>.from(
                  jsonDecode(app.imageUrls).map((e) => e.toString())),
              category: AppCategory.values.byName(app.category),
              esrbRating: EsrbRating.values.byName(app.esrbRating),
              pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
              inAppPurchaseModel: InAppPurchaseModel.fromMap(
                  jsonDecode(app.inAppPurchaseModel)),
              forceLatest: app.forceLatest,
              systemRequirements: List<SystemRequirements>.from(
                  jsonDecode(app.systemRequirements)
                      .map((e) => SystemRequirements.fromMap(e))),
              permissions: Permissions.fromMap(jsonDecode(app.permissions)),
              supportedLanguages:
                  List<String>.from(jsonDecode(app.supportedLanguages)),
              supportedPlatforms: List<SupportedPlatform>.from(
                  jsonDecode(app.supportedPlatforms)
                      .map((e) => SupportedPlatform.fromMap(e))),
              codeSource: app.codeSource,
              homepage: app.homepage,
              supportEmail: app.supportEmail,
              license: app.license,
              links: List<String>.from(jsonDecode(app.links)),
              publishedOn: app.publishedOn,
              updatedOn: app.updatedOn,
            ),
          );
        }
      } else {
        notifyNullEvent("watchAppsByMaintainer", maintainer);
      }
      prettyLog(
          value:
              '[WatchUserAppsStream] There are ${userApps.length} apps in db');
      controller.add(userApps);
    });
    return controller.stream;
  }

  Future<Stream<List<AppEntity>>> watchAppsByPage({
    required String page,
  }) async {
    prettyLog(value: '[Database] Creating app watcher for $page page');
    final appsStream = _getApps().watch();
    final controller = StreamController<List<AppEntity>>();
    appsStream.listen((apps) {
      final userApps = <AppEntity>[];
      if (apps.isNotEmpty) {
        for (final app in apps) {
          userApps.add(
            AppEntity(
              appID: app.appID,
              maintainer: app.maintainer,
              packageID: app.packageID,
              name: app.name,
        verified: app.verified,
              pages: Set<String>.from(jsonDecode(app.pages)),
              headings: Set<String>.from(jsonDecode(app.headings)),
              shortDescription: app.shortDescription,
              description: List<String>.from(
                  jsonDecode(app.description).map((e) => e.toString())),
              tags: List<String>.from(
                  jsonDecode(app.tags).map((e) => e.toString())),
              icon: app.icon,
              bannerImage: app.bannerImage,
              imageUrls: List<String>.from(
                  jsonDecode(app.imageUrls).map((e) => e.toString())),
              category: AppCategory.values.byName(app.category),
              esrbRating: EsrbRating.values.byName(app.esrbRating),
              pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
              inAppPurchaseModel: InAppPurchaseModel.fromMap(
                  jsonDecode(app.inAppPurchaseModel)),
              forceLatest: app.forceLatest,
              systemRequirements: List<SystemRequirements>.from(
                  jsonDecode(app.systemRequirements)
                      .map((e) => SystemRequirements.fromMap(e))),
              permissions: Permissions.fromMap(jsonDecode(app.permissions)),
              supportedLanguages:
                  List<String>.from(jsonDecode(app.supportedLanguages)),
              supportedPlatforms: List<SupportedPlatform>.from(
                  jsonDecode(app.supportedPlatforms)
                      .map((e) => SupportedPlatform.fromMap(e))),
              codeSource: app.codeSource,
              homepage: app.homepage,
              supportEmail: app.supportEmail,
              license: app.license,
              links: List<String>.from(jsonDecode(app.links)),
              publishedOn: app.publishedOn,
              updatedOn: app.updatedOn,
            ),
          );
        }
      } else {
        notifyNullEvent("watchAppsByPages", page);
      }
      userApps.removeWhere((app) => !app.pages.contains(page));
      prettyLog(
          value:
              '[Watch${page.split(' ').join()}Stream] There are ${userApps.length} apps in db');
      controller.add(userApps);
    });
    final stream = controller.stream;
    return stream;
  }

  Future<Stream<List<AppEntity>>> watchApps({
    required List<String> appIDs,
  }) async {
    prettyLog(
        value: '[Database] Creating an app watcher for a specific set of apps');
    final appsStream = _getApps().watch();
    final controller = StreamController<List<AppEntity>>();
    appsStream.listen((apps) {
      final userApps = <AppEntity>[];
      if (apps.isNotEmpty) {
        for (final app in apps) {
          userApps.add(
            AppEntity(
              appID: app.appID,
              maintainer: app.maintainer,
              packageID: app.packageID,
              name: app.name,
        verified: app.verified,
              pages: Set<String>.from(jsonDecode(app.pages)),
              headings: Set<String>.from(jsonDecode(app.headings)),
              shortDescription: app.shortDescription,
              description: List<String>.from(
                  jsonDecode(app.description).map((e) => e.toString())),
              tags: List<String>.from(
                  jsonDecode(app.tags).map((e) => e.toString())),
              icon: app.icon,
              bannerImage: app.bannerImage,
              imageUrls: List<String>.from(
                  jsonDecode(app.imageUrls).map((e) => e.toString())),
              category: AppCategory.values.byName(app.category),
              esrbRating: EsrbRating.values.byName(app.esrbRating),
              pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
              inAppPurchaseModel: InAppPurchaseModel.fromMap(
                  jsonDecode(app.inAppPurchaseModel)),
              forceLatest: app.forceLatest,
              systemRequirements: List<SystemRequirements>.from(
                  jsonDecode(app.systemRequirements)
                      .map((e) => SystemRequirements.fromMap(e))),
              permissions: Permissions.fromMap(jsonDecode(app.permissions)),
              supportedLanguages:
                  List<String>.from(jsonDecode(app.supportedLanguages)),
              supportedPlatforms: List<SupportedPlatform>.from(
                  jsonDecode(app.supportedPlatforms)
                      .map((e) => SupportedPlatform.fromMap(e))),
              codeSource: app.codeSource,
              homepage: app.homepage,
              supportEmail: app.supportEmail,
              license: app.license,
              links: List<String>.from(jsonDecode(app.links)),
              publishedOn: app.publishedOn,
              updatedOn: app.updatedOn,
            ),
          );
        }
      } else {
        notifyNullEvent("watchApps:CUSTOM", appIDs.toString());
      }
      userApps.removeWhere((app) => !appIDs.contains(app.appID));
      prettyLog(
          value:
              '[WatchAppsStream:CUSTOM] There are ${userApps.length} apps in db');
      controller.add(userApps);
    });
    final stream = controller.stream;
    return stream;
  }

  Future<Stream<AppEntity?>> watchApp({required String appID}) async {
    final appStream = _getApp(appID).watch();
    final controller = StreamController<AppEntity?>();
    appStream.listen((apps) {
      if (apps.isEmpty) {
        notifyNullEvent("watchApp", appID);
        controller.add(null);
      } else {
        final app = apps.first;
        final entity = AppEntity(
          appID: app.appID,
          maintainer: app.maintainer,
          packageID: app.packageID,
          name: app.name,
        verified: app.verified,
          pages: Set<String>.from(jsonDecode(app.pages)),
          headings: Set<String>.from(jsonDecode(app.headings)),
          shortDescription: app.shortDescription,
          description: List<String>.from(
              jsonDecode(app.description).map((e) => e.toString())),
          tags:
              List<String>.from(jsonDecode(app.tags).map((e) => e.toString())),
          icon: app.icon,
          bannerImage: app.bannerImage,
          imageUrls: List<String>.from(
              jsonDecode(app.imageUrls).map((e) => e.toString())),
          category: AppCategory.values.byName(app.category),
          esrbRating: EsrbRating.values.byName(app.esrbRating),
          pricingModel: PricingModel.fromMap(jsonDecode(app.pricingModel)),
          inAppPurchaseModel:
              InAppPurchaseModel.fromMap(jsonDecode(app.inAppPurchaseModel)),
          forceLatest: app.forceLatest,
          systemRequirements: List<SystemRequirements>.from(
              jsonDecode(app.systemRequirements)
                  .map((e) => SystemRequirements.fromMap(e))),
          permissions: Permissions.fromMap(jsonDecode(app.permissions)),
          supportedLanguages:
              List<String>.from(jsonDecode(app.supportedLanguages)),
          supportedPlatforms: List<SupportedPlatform>.from(
              jsonDecode(app.supportedPlatforms)
                  .map((e) => SupportedPlatform.fromMap(e))),
          codeSource: app.codeSource,
          homepage: app.homepage,
          supportEmail: app.supportEmail,
          license: app.license,
          links: List<String>.from(jsonDecode(app.links)),
          publishedOn: app.publishedOn,
          updatedOn: app.updatedOn,
        );
        controller.add(entity);
      }
    });
    return controller.stream;
  }

  /// a function to add the [AppReviewEntity] objects into the [AppReviewTable]
  Future<void> addAppReviews(List<AppReviewEntity> appReviews) async {
    debugPrint(
        "[Database] Adding ${appReviews.length} AppReviewEntity objects ...");
    await batch((batch) {
      batch.insertAll(
        appReviewTable,
        appReviews.map((appReview) {
          return AppReviewTableCompanion.insert(
            appID: appReview.appID,
            reviews: jsonEncode(List<Map<String, dynamic>>.from(
                appReview.reviews.map((e) => e.toMap()))),
          );
        }),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// a function to remove the [AppReviewEntity] objects into the [AppReviewTable]
  Future<void> deleteAppReviews(List<String> appIDs) async {
    debugPrint(
        "[Database] Deleting ${appIDs.length} AppReviewEntity objects ...");
    await batch((batch) {
      batch.deleteWhere(
        appReviewTable,
        (app) => app.appID.isIn(appIDs),
      );
    });
  }

  Future<Stream<AppReviewEntity>> watchAppReviews(
      {required String appID}) async {
    final appReviewsStream = _getAppReviews(appID).watch();
    final controller = StreamController<AppReviewEntity>();
    appReviewsStream.listen((appReviews) {
      if (appReviews.isEmpty) {
        notifyNullEvent("watchAppReviews", appID);
        controller.add(AppReviewEntity(appID: appID, reviews: []));
      } else {
        final appReview = appReviews.first;
        final entity = AppReviewEntity(
          appID: appReview.appID,
          reviews: List<AppReview>.from(
              jsonDecode(appReview.reviews).map((e) => AppReview.fromMap(e))),
        );
        controller.add(entity);
      }
    });
    return controller.stream;
  }
}

void notifyNullEvent(String functionName, String argument) {
  debugPrint(
      "[Database] No results for `$functionName` call with argument `$argument`");
}

DatabaseConnection connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'fusion_app_store_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      debugPrint(
        'Using ${result.chosenImplementation.name} due to missing browser\n'
        'features: ${result.missingFeatures.join(", ")}',
      );
    }

    return result.resolvedExecutor;
  }));
}
