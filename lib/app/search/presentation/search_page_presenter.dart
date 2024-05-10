import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/search/domain/usecases/search_apps_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_current_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_local_apps_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

class SearchPagePresenter extends Presenter {
  final SearchAppsUsecase _searchAppsUsecase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GetLocalAppsUseCase _getLocalAppsUseCase;

  SearchPagePresenter(this._searchAppsUsecase, this._getCurrentUserUseCase,
      this._getLocalAppsUseCase);

  @override
  void dispose() {
    _searchAppsUsecase.dispose();
    _getCurrentUserUseCase.dispose();
    _getLocalAppsUseCase.dispose();
  }

  void search({
    required UseCaseObserver observer,
    required String query,
  }) {
    _searchAppsUsecase.execute(observer, {
      "query": query,
    });
  }

  void findCurrentUser({required UseCaseObserver observer}) {
    _getCurrentUserUseCase.execute(observer);
  }

  void fetchLocalApps({required UseCaseObserver observer}) {
    _getLocalAppsUseCase.execute(observer);
  }
}
