import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_presenter.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_state_machine.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/core/global/status_panel.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class SearchPageController
    extends Controller<SearchPageState, SearchPageEvent> {
  SearchPageController() : super(stateMachine: SearchPageStateMachine()) {
    _presenter = Get.find<SearchPagePresenter>();
  }

  late final SearchPagePresenter _presenter;

  @override
  void initListeners() {}

  void init(String query, String platform) {
    PlatformType platformType = NativePlatformType.identify(platform);
    if (query.isEmpty) {
      _presenter.fetchLocalApps(
        observer: UseCaseObserver<List<AppEntity>>(
          name: "FetchLocalApps:SEARCH",
          onNextValue: (localApps) {
            _presenter.findCurrentUser(
              observer: UseCaseObserver<UserEntity?>(
                name: "FindCurrentUser:SEARCH",
                onNextValue: (user) {
                  if (user != null) {
                    onEvent(
                      SearchPageInitializedEvent(
                        userEntity: user,
                        searchQuery: "",
                        platformType: platformType,
                        apps: [],
                        localApps: localApps!,
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      );
    } else {
      searchApps(query, platformType);
    }
  }

  void gotoDashboard({ViewType? initialViewType}) {
    Get.find<RouteService>().navigateTo(
      page: RouteService.dashboardPage,
      arguments: DashboardPageArguments(
        isOnBoarded: false,
        isUserLoggedIn: true,
        initialViewType: initialViewType,
      ),
    );
  }

  void searchApps(String query, PlatformType platformType) {
    showLoader("Finding Apps");
    _presenter.search(
      observer: UseCaseObserver<List<AppEntity>>(
        name: "SearchApps:SEARCH",
        onNextValue: (apps) {
          _presenter.fetchLocalApps(
            observer: UseCaseObserver<List<AppEntity>>(
              name: "FetchLocalApps:SEARCH",
              onNextValue: (localApps) {
                _presenter.findCurrentUser(
                  observer: UseCaseObserver<UserEntity?>(
                    name: "FindCurrentUser:SEARCH",
                    onNextValue: (user) {
                      if (user != null) {
                        onEvent(
                          SearchPageInitializedEvent(
                            userEntity: user,
                            searchQuery: query,
                            platformType: platformType,
                            apps: apps!,
                            localApps: localApps!,
                          ),
                        );
                      }
                      hideLoader();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      query: query,
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
}
