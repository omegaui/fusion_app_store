import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_join_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_with_google_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_with_username_and_password_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_logout_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

class AuthPagePresenter extends Presenter {
  final UserLoginStatusUseCase _userLoginStatusUseCase;
  final UserLoginWithGoogleUseCase _userLoginWithGoogleUseCase;
  final UserLoginWithUsernameAndPasswordUseCase
      _userLoginWithUsernameAndPasswordUseCase;
  final UserJoinStatusUseCase _userJoinStatusUseCase;
  final UserLogOutUseCase _userLogOutUseCase;

  AuthPagePresenter(
    this._userLoginStatusUseCase,
    this._userLoginWithGoogleUseCase,
    this._userLoginWithUsernameAndPasswordUseCase,
    this._userJoinStatusUseCase,
    this._userLogOutUseCase,
  );

  @override
  void dispose() {
    _userLoginStatusUseCase.dispose();
    _userLoginWithGoogleUseCase.dispose();
    _userLoginWithUsernameAndPasswordUseCase.dispose();
    _userJoinStatusUseCase.dispose();
    _userLogOutUseCase.dispose();
  }

  void findUserLoginStatus({required UseCaseObserver observer}) {
    _userLoginStatusUseCase.execute(observer);
  }

  void performLoginWithGoogle({required UseCaseObserver observer}) {
    _userLoginWithGoogleUseCase.execute(observer);
  }

  void performLoginWithUsernameAndPassword({
    required String username,
    required String password,
    required UseCaseObserver observer,
  }) {
    _userLoginWithUsernameAndPasswordUseCase.execute(observer,
        UserLoginWithUsernameAndPasswordUseCaseParams(username, password));
  }

  void isNewlyJoined({required UseCaseObserver observer}) {
    _userJoinStatusUseCase.execute(observer);
  }

  void logOut({required UseCaseObserver observer}) {
    _userLogOutUseCase.execute(observer);
  }
}
