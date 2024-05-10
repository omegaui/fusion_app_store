import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class WatchReviewedAppsUseCase extends CompletableUseCase<List<String>> {
  final DashboardRepository _repository;

  WatchReviewedAppsUseCase(this._repository);

  @override
  Future<Stream<List<AppEntity>>> buildUseCaseStream(
      List<String>? params) async {
    StreamController<List<AppEntity>> controller = StreamController();
    try {
      controller
          .addStream(await _repository.watchReviewedApps(appIDs: params!));
    } catch (e) {
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
