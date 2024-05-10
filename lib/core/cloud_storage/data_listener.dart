import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:get/get.dart';

class DataListener {
  final _db = Get.find<FusionDatabase>();
  final Map<String, StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
      _activeStreamMap = {};
  final Set<String> _preloadedKeys = {};

  Future<void> closeConnection() async {
    final subscriptions = _activeStreamMap.values;
    final futures = <Future>[];
    for (final subscription in subscriptions) {
      futures.add(subscription.cancel());
    }
    await Future.wait(futures);
    _activeStreamMap.clear();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenUsers(
      String key, Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    if (!_activeStreamMap.containsKey(key)) {
      _activeStreamMap[key] = stream.listen((event) async {
        if (!_preloadedKeys.contains(key)) {
          final docs = event.docs;
          final users = <UserEntity>[];
          if (docs.isNotEmpty) {
            for (final doc in docs) {
              users.add(UserEntity.fromMap(map: doc.data()));
            }
            await _db.addUsers(users);
          }
          _preloadedKeys.add(key);
        } else {
          final docChanges = event.docChanges;
          if (docChanges.isNotEmpty) {
            final additions = <UserEntity>[];
            final deletions = <UserEntity>[];
            for (final change in docChanges) {
              switch (change.type) {
                case DocumentChangeType.added:
                case DocumentChangeType.modified:
                  additions.add(UserEntity.fromMap(map: change.doc.data()!));
                  break;
                case DocumentChangeType.removed:
                  deletions.add(UserEntity.fromMap(map: change.doc.data()!));
              }
            }

            final futures = <Future>[];
            futures.add(_db.addUsers(additions));
            for (final user in deletions) {
              futures.add(_db.deleteUser(user.username));
            }

            if (futures.isNotEmpty) {
              await Future.wait(futures);
            }
          }
        }
      });
    } else {
      _close(stream);
    }
    return _activeStreamMap[key]!;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenApps(
      String key, Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    if (!_activeStreamMap.containsKey(key)) {
      _activeStreamMap[key] = stream.listen((event) async {
        if (!_preloadedKeys.contains(key)) {
          final docs = event.docs;
          final apps = <AppEntity>[];
          if (docs.isNotEmpty) {
            for (final doc in docs) {
              apps.add(AppEntity.fromMap(doc.data()));
            }
            if (apps.isNotEmpty) {
              await _db.addApps(apps);
            }
          }
          _preloadedKeys.add(key);
        } else {
          final docChanges = event.docChanges;
          if (docChanges.isNotEmpty) {
            final additions = <AppEntity>[];
            final deletions = <AppEntity>[];
            for (final change in docChanges) {
              switch (change.type) {
                case DocumentChangeType.added:
                case DocumentChangeType.modified:
                  additions.add(AppEntity.fromMap(change.doc.data()!));
                  break;
                case DocumentChangeType.removed:
                  deletions.add(AppEntity.fromMap(change.doc.data()!));
              }
            }

            final futures = <Future>[];
            futures.add(_db.addApps(additions));
            futures.add(_db.deleteApps([...deletions.map((e) => e.appID)]));

            if (futures.isNotEmpty) {
              await Future.wait(futures);
            }
          }
        }
      });
    } else {
      _close(stream);
    }
    return _activeStreamMap[key]!;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listenAppReviews(
      String key, Stream<QuerySnapshot<Map<String, dynamic>>> stream) {
    if (!_activeStreamMap.containsKey(key)) {
      _activeStreamMap[key] = stream.listen((event) async {
        if (!_preloadedKeys.contains(key)) {
          final docs = event.docs;
          final apps = <AppReviewEntity>[];
          if (docs.isNotEmpty) {
            for (final doc in docs) {
              apps.add(AppReviewEntity.fromMap(doc.id, doc.data()));
            }
            if (apps.isNotEmpty) {
              await _db.addAppReviews(apps);
            }
          }
          _preloadedKeys.add(key);
        } else {
          final docChanges = event.docChanges;
          if (docChanges.isNotEmpty) {
            final additions = <AppReviewEntity>[];
            final deletions = <AppReviewEntity>[];
            for (final change in docChanges) {
              switch (change.type) {
                case DocumentChangeType.added:
                case DocumentChangeType.modified:
                  additions.add(AppReviewEntity.fromMap(
                      change.doc.id, change.doc.data()!));
                  break;
                case DocumentChangeType.removed:
                  deletions.add(AppReviewEntity.fromMap(
                      change.doc.id, change.doc.data()!));
              }
            }

            final futures = <Future>[];
            futures.add(_db.addAppReviews(additions));
            futures
                .add(_db.deleteAppReviews([...deletions.map((e) => e.appID)]));

            if (futures.isNotEmpty) {
              await Future.wait(futures);
            }
          }
        }
      });
    } else {
      _close(stream);
    }
    return _activeStreamMap[key]!;
  }

  Future<List<UserEntity>> instantLoadUsers(List<String> targetUsers) async {
    final originalTargets = [...targetUsers];
    await _db.filterAbsentUsers(targetUsers);
    if (targetUsers.isNotEmpty) {
      final docs = (await Refs.users
              .where(StorageKeys.username, whereIn: targetUsers)
              .get())
          .docs;
      final users = <UserEntity>[];
      if (docs.isNotEmpty) {
        for (final doc in docs) {
          users.add(UserEntity.fromMap(map: doc.data()));
        }
        await _db.addUsers(users);
      }
    }
    return _db.getUsers(originalTargets);
  }

  Future<List<AppEntity>> instantLoadApps(List<String> targetApps) async {
    final originalTargets = [...targetApps];
    await _db.filterAbsentApps(targetApps);
    if (targetApps.isNotEmpty) {
      final docs =
          (await Refs.apps.where(StorageKeys.appID, whereIn: targetApps).get())
              .docs;
      final apps = <AppEntity>[];
      if (docs.isNotEmpty) {
        for (final doc in docs) {
          apps.add(AppEntity.fromMap(doc.data()));
        }
        await _db.addApps(apps);
      }
    }
    return _db.getApps(originalTargets);
  }

  void _close(Stream stream) async {
    // prevents duplicate listeners
    StreamController<dynamic> controller = StreamController();
    await controller.addStream(stream);
    await controller.close();
  }
}
