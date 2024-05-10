import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class GetCurrentUserUseCase extends CompletableUseCase<void> {
  final StoreRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Stream<UserEntity?>> buildUseCaseStream(void params) async {
    StreamController<UserEntity?> controller = StreamController();
    try {
      controller.add(await _repository.getCurrentUser());
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
