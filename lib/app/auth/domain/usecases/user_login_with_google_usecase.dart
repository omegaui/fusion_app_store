import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';

class UserLoginWithGoogleUseCase extends CompletableUseCase<void> {
  final AuthRepository _repository;

  UserLoginWithGoogleUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      controller.add(await _repository.loginWithGoogle());
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
