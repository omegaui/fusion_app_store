import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';

class UserLoginWithUsernameAndPasswordUseCase
    extends CompletableUseCase<UserLoginWithUsernameAndPasswordUseCaseParams> {
  final AuthRepository _repository;

  UserLoginWithUsernameAndPasswordUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(
      UserLoginWithUsernameAndPasswordUseCaseParams? params) async {
    StreamController<bool> controller = StreamController();
    try {
      controller.add(await _repository.loginWithUsernameAndPassword(
        username: params!.username,
        password: params.password,
      ));
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}

class UserLoginWithUsernameAndPasswordUseCaseParams {
  final String username;
  final String password;

  UserLoginWithUsernameAndPasswordUseCaseParams(this.username, this.password);
}
