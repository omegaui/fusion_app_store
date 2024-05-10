import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';

class FindUserUseCase extends CompletableUseCase<String> {
  final StoreRepository _storeRepository;

  FindUserUseCase(this._storeRepository);

  @override
  Future<Stream<UserEntity?>> buildUseCaseStream(String? params) async {
    StreamController<UserEntity?> controller = StreamController();
    try {
      final user = await _storeRepository.findUser(id: params!);
      controller.add(user);
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
