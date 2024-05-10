import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class WatchAppsByPageUseCase extends CompletableUseCase<String> {
  final StoreRepository _repository;

  WatchAppsByPageUseCase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(String? params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller.addStream(await _repository.getAppsByPage(page: params!));
    } catch (e) {
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
