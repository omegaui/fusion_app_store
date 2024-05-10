import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/usecases/find_user_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

import '../../domain/usecases/get_apps_by_user_usecase.dart';

class UserViewPagePresenter extends Presenter {
  final FindUserUseCase _findUserUseCase;
  final GetAppsByUserUseCase _getAppsByUserUseCase;

  UserViewPagePresenter(this._findUserUseCase, this._getAppsByUserUseCase);

  @override
  void dispose() {}

  void findUser({required String id, required UseCaseObserver observer}) {
    _findUserUseCase.execute(observer, id);
  }

  void getAppsByUser(
      {required UserEntity user, required UseCaseObserver observer}) {
    _getAppsByUserUseCase.execute(observer, user);
  }
}
