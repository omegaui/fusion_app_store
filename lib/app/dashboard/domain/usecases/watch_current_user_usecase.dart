import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';

class WatchCurrentUserUseCase extends CompletableUseCase<void> {
  final DashboardRepository _repository;

  WatchCurrentUserUseCase(this._repository);

  @override
  Future<Stream<UserEntity>> buildUseCaseStream(void params) async {
    StreamController<UserEntity> controller = StreamController();
    try {
      controller.addStream(await _repository.watchCurrentUser());
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
