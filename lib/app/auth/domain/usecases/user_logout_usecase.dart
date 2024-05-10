import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';

class UserLogOutUseCase extends CompletableUseCase<void> {
  final AuthRepository _repository;

  UserLogOutUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      controller.add(await _repository.logout());
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
