import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class GetLocalAppsUseCase extends CompletableUseCase<void> {
  final StoreRepository _repository;

  GetLocalAppsUseCase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(void params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller.add(await _repository.getLocalApps());
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
