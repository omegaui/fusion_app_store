import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/domain/repository/onboarding_repository.dart';

class UpdateUserUseCase extends CompletableUseCase<UserEntity> {
  final OnBoardingRepository _repository;

  UpdateUserUseCase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(UserEntity? params) async {
    StreamController<void> controller = StreamController();
    try {
      controller.add(await _repository.updateUser(userEntity: params!));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
