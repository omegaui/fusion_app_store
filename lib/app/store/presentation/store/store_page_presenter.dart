import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/usecases/home_page_watch_apps_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/watch_apps_by_page.dart';
import 'package:fusion_app_store/app/store/domain/usecases/watch_users_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

import '../../domain/usecases/get_current_user_usecase.dart';

class StorePagePresenter extends Presenter {
  final WatchUsersUseCase _watchUsersUseCase;
  final WatchHomePageAppsUseCase _watchHomePageAppsUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final WatchAppsByPageUseCase _watchAppsByPageUseCase;

  StorePagePresenter(
    this._watchUsersUseCase,
    this._getCurrentUserUseCase,
    this._watchHomePageAppsUseCase,
    this._watchAppsByPageUseCase,
  );

  @override
  void dispose() {
    _watchUsersUseCase.dispose();
    _getCurrentUserUseCase.dispose();
    _watchHomePageAppsUseCase.dispose();
    _watchAppsByPageUseCase.dispose();
  }

  void watchUsers({required UseCaseObserver observer}) {
    _watchUsersUseCase.execute(observer);
  }

  void findCurrentUser({required UseCaseObserver observer}) {
    _getCurrentUserUseCase.execute(observer);
  }

  void watchHomePageApps({required UseCaseObserver observer}) {
    _watchHomePageAppsUseCase.execute(observer);
  }

  void watchAppsByPage({
    required UseCaseObserver observer,
    required String page,
  }) {
    _watchAppsByPageUseCase.execute(observer, page);
  }
}
