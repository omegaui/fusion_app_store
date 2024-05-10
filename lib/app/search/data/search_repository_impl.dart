import 'package:fusion_app_store/app/search/domain/repository/search_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/core/cloud_storage/keys.dart';
import 'package:fusion_app_store/core/cloud_storage/refs.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:get/get.dart';

class SearchRepositoryImpl extends SearchRepository {
  final _db = Get.find<FusionDatabase>();

  @override
  Future<List<AppEntity>> search({
    required String query,
  }) async {
    final localApps = await _db.getAllApps();
    final localAppIDs = {
      ...localApps
          .where((e) => e.name.isCaseInsensitiveContains(query))
          .map((e) => e.appID)
    };

    final docRef = localAppIDs.isNotEmpty
        ? Refs.apps
            // we only fetch apps that are already present in the db
            .where(StorageKeys.appID, whereNotIn: localAppIDs.take(10))
            .where(StorageKeys.search, arrayContains: query)
        : Refs.apps.where(StorageKeys.search, arrayContains: query);

    final docs = (await docRef.get()).docs;
    final remoteApps = <AppEntity>[];
    if (docs.isNotEmpty) {
      for (final doc in docs) {
        remoteApps.add(AppEntity.fromMap(doc.data()));
      }
      await _db.addApps(remoteApps);
    }

    localApps.removeWhere((e) => !e.name.isCaseInsensitiveContains(query));

    return [...remoteApps, ...localApps];
  }
}
