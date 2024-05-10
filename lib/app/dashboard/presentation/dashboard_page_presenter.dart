import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_join_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_logout_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/delete_app_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/upload_app_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_apps_by_user_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_current_user_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_liked_apps_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_reviewed_apps_usecase.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/domain/usecases/update_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

class DashboardPagePresenter extends Presenter {
  final UserLoginStatusUseCase _userLoginStatusUseCase;
  final UserJoinStatusUseCase _userJoinStatusUseCase;
  final WatchCurrentUserUseCase _watchCurrentUserUseCase;
  final WatchAppsByUserUseCase _watchAppsByUserUseCase;
  final UploadAppUseCase _uploadAppUseCase;
  final UserLogOutUseCase _logOutUseCase;
  final WatchLikedAppsUseCase _watchLikedAppsUseCase;
  final WatchReviewedAppsUseCase _watchReviewedAppsUseCase;
  final DeleteAppUseCase _deleteAppUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  DashboardPagePresenter(
    this._userLoginStatusUseCase,
    this._userJoinStatusUseCase,
    this._watchCurrentUserUseCase,
    this._watchAppsByUserUseCase,
    this._uploadAppUseCase,
    this._logOutUseCase,
    this._watchLikedAppsUseCase,
    this._watchReviewedAppsUseCase,
    this._deleteAppUseCase,
    this._updateUserUseCase,
  );

  @override
  void dispose() {
    _userLoginStatusUseCase.dispose();
    _userJoinStatusUseCase.dispose();
    _watchCurrentUserUseCase.dispose();
    _watchAppsByUserUseCase.dispose();
    _uploadAppUseCase.dispose();
    _logOutUseCase.dispose();
    _watchLikedAppsUseCase.dispose();
    _watchReviewedAppsUseCase.dispose();
    _deleteAppUseCase.dispose();
    _updateUserUseCase.dispose();
  }

  void findUserLoginStatus({required UseCaseObserver observer}) {
    _userLoginStatusUseCase.execute(observer);
  }

  void isNewlyJoined({required UseCaseObserver observer}) {
    _userJoinStatusUseCase.execute(observer);
  }

  void watchCurrentUser({required UseCaseObserver observer}) {
    _watchCurrentUserUseCase.execute(observer);
  }

  void watchAppsByUser({
    required String username,
    required UseCaseObserver observer,
  }) {
    _watchAppsByUserUseCase.execute(observer, username);
  }

  void uploadApp({
    required AppEntity appEntity,
    required UseCaseObserver observer,
  }) {
    _uploadAppUseCase.execute(observer, appEntity);
  }

  void deleteApp({
    required AppEntity appEntity,
    required UseCaseObserver observer,
  }) {
    _deleteAppUseCase.execute(observer, appEntity);
  }

  void logOut({required UseCaseObserver observer}) {
    _logOutUseCase.execute(observer);
  }

  void watchLikedApps({
    required UseCaseObserver observer,
    required List<String> appIDs,
  }) {
    _watchLikedAppsUseCase.execute(observer, appIDs);
  }

  void watchReviewedApps({
    required UseCaseObserver observer,
    required List<String> appIDs,
  }) {
    _watchReviewedAppsUseCase.execute(observer, appIDs);
  }

  void updateUser({
    required UserEntity userEntity,
    required UseCaseObserver observer,
  }) {
    _updateUserUseCase.execute(observer, userEntity);
  }
}
