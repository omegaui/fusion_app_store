import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class GetAppReviewsByIDUseCase extends CompletableUseCase<String> {
  final StoreRepository _repository;

  GetAppReviewsByIDUseCase(this._repository);

  @override
  Future<Stream<AppReviewEntity>> buildUseCaseStream(String? params) async {
    StreamController<AppReviewEntity> controller = StreamController();
    try {
      controller.addStream(await _repository.getAppReviewsByID(appID: params!));
    } catch (e) {
      controller.addError(e);
      controller.close();
    }
    return controller.stream;
  }
}
