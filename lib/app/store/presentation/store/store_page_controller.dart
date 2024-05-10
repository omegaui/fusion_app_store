import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/arguments/store_page_arguments.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_presenter.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_state_machine.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_states_and_events.dart';
import 'package:fusion_app_store/constants/store_pages.dart';
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class StorePageController extends Controller<StorePageState, StorePageEvent> {
  StorePageController() : super(stateMachine: StorePageStateMachine()) {
    _presenter = Get.find<StorePagePresenter>();
  }

  late final StorePagePresenter _presenter;
  late StorePageArguments arguments;

  // currently active store page
  String _activeStorePage = StorePages.home;

  String get activeStorePage => _activeStorePage;

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void onStorePageChanged(String type) {
    if (_activeStorePage != type) {
      _activeStorePage = type;
      init(arguments);
    }
  }

  void init(StorePageArguments arguments) {
    this.arguments = arguments;
    if (arguments.isUserLoggedIn) {
      final targetStorePage = _activeStorePage;
      _presenter.findCurrentUser(
        observer: UseCaseObserver<UserEntity?>(
          name: "FindCurrentUserInStore",
          onNextValue: (user) {
            _presenter.watchUsers(
              observer: UseCaseObserver(
                name: "WatchUsers",
                onFinish: () {
                  _presenter.watchHomePageApps(
                    observer: UseCaseObserver(
                      name: "WatchHomePageApps",
                      onFinish: () {
                        _presenter.watchAppsByPage(
                          observer: UseCaseObserver<List<AppEntity>>(
                            name: 'WatchAppsByPage:$targetStorePage',
                            onNextValue: (List<AppEntity>? apps) {
                              // this will prevent unnecessary rebuilds from
                              // non-active pages
                              if (activeStorePage == targetStorePage) {
                                onEvent(
                                  StorePageInitializedEvent(
                                    userEntity: user,
                                    apps: apps ?? [],
                                  ),
                                );
                                refreshUI();
                              }
                            },
                          ),
                          page: targetStorePage,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      prettyLog(value: 'User is not logged in!');
      onEvent(StorePageInitializedEvent(apps: []));
    }
  }

  void gotoDashboard({ViewType? initialViewType}) {
    Get.find<RouteService>().navigateTo(
      page: RouteService.dashboardPage,
      arguments: DashboardPageArguments(
        isOnBoarded: arguments.isOnBoarded,
        isUserLoggedIn: arguments.isUserLoggedIn,
        initialViewType: initialViewType,
      ),
    );
  }

  void viewApp(AppEntity app) {
    Get.find<RouteService>().navigateTo(
      page: RouteService.appPage,
      parameters: {
        'id': app.appID,
      },
    );
  }

  void gotoSearch() {
    Get.find<RouteService>().navigateTo(
      page: RouteService.searchPage,
    );
  }
}
