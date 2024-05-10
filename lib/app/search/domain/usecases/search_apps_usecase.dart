import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/search/domain/repository/search_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class SearchAppsUsecase extends CompletableUseCase<Map<String, dynamic>> {
  final SearchRepository _repository;

  SearchAppsUsecase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(
      Map<String, dynamic>? params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller.add(await _repository.search(
        query: params!["query"]!,
      ));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
