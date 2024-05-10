import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';

class UserLoginStatusUseCase extends CompletableUseCase<void> {
  final AuthRepository _repository;

  UserLoginStatusUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      final result = await _repository.isUserLoggedIn();
      controller.add(result);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
