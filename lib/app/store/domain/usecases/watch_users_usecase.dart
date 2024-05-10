import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class WatchUsersUseCase extends CompletableUseCase<void> {
  final StoreRepository _repository;

  WatchUsersUseCase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _repository.watchUsers();
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
