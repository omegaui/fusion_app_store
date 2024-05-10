import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class DeleteAppUseCase extends CompletableUseCase<AppEntity> {
  final DashboardRepository _repository;

  DeleteAppUseCase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(AppEntity? params) async {
    StreamController<void> controller = StreamController();
    try {
      controller.add(await _repository.deleteApp(appEntity: params!));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
