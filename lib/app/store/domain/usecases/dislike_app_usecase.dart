import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class DislikeAppUseCase extends CompletableUseCase<AppEntity> {
  final StoreRepository _repository;

  DislikeAppUseCase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(AppEntity? params) async {
    StreamController<void> controller = StreamController();
    try {
      controller.add(await _repository.dislikeApp(appEntity: params!));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
