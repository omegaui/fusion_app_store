import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class ReviewAppUseCase extends CompletableUseCase<Map<String, dynamic>> {
  final StoreRepository _repository;

  ReviewAppUseCase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(Map<String, dynamic>? params) async {
    StreamController<void> controller = StreamController();
    try {
      controller.add(await _repository.reviewApp(
        appEntity: params!['appEntity'],
        appReview: params['appReview'],
      ));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
