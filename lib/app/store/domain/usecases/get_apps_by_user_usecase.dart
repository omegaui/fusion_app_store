import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class GetAppsByUserUseCase extends CompletableUseCase<UserEntity> {
  final StoreRepository _repository;

  GetAppsByUserUseCase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(UserEntity? params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller.add(await _repository.getAppsByUser(userEntity: params!));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
