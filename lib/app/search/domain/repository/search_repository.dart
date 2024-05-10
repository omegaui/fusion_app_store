import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

abstract class SearchRepository {
  Future<List<AppEntity>> search({
    required String query,
  });
}
