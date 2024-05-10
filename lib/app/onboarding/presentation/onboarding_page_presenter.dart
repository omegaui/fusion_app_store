import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_join_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_logout_usecase.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/domain/usecases/update_user_usecase.dart';
import 'package:fusion_app_store/app/onboarding/domain/usecases/username_available_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

class OnBoardingPagePresenter extends Presenter {
  final UpdateUserUseCase _updateUserUseCase;
  final UsernameAvailableUseCase _usernameAvailableUseCase;
  final UserLogOutUseCase _userLogoutUseCase;
  final UserJoinStatusUseCase _userJoinStatusUseCase;

  OnBoardingPagePresenter(
      this._updateUserUseCase,
      this._usernameAvailableUseCase,
      this._userLogoutUseCase,
      this._userJoinStatusUseCase);

  @override
  void dispose() {
    _updateUserUseCase.dispose();
    _usernameAvailableUseCase.dispose();
    _userLogoutUseCase.dispose();
    _userJoinStatusUseCase.dispose();
  }

  void updateUser({
    required UserEntity userEntity,
    required UseCaseObserver observer,
  }) {
    _updateUserUseCase.execute(observer, userEntity);
  }

  void logout({
    required UseCaseObserver observer,
  }) {
    _userLogoutUseCase.execute(observer);
  }

  void checkIfUsernameAvailable({
    required String username,
    required UseCaseObserver observer,
  }) {
    _usernameAvailableUseCase.execute(observer, username);
  }

  void isNewlyJoined({required UseCaseObserver observer}) {
    _userJoinStatusUseCase.execute(observer);
  }
}
