import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/repository/onboarding_repository.dart';

class UsernameAvailableUseCase extends CompletableUseCase<String> {
  final OnBoardingRepository _repository;

  UsernameAvailableUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(String? params) async {
    StreamController<bool> controller = StreamController();
    try {
      final result = await _repository.isUsernameAvailable(username: params!);
      controller.add(result);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
