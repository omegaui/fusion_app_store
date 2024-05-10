import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class WatchAppsByUserUseCase extends CompletableUseCase<String> {
  final DashboardRepository _repository;

  WatchAppsByUserUseCase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(String? params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller
          .addStream(await _repository.watchUserApps(maintainer: params!));
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
