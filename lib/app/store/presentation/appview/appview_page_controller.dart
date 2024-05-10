import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_presenter.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_state_machine.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_states_and_events.dart';
import 'package:fusion_app_store/core/cloud_storage/data_listener.dart';
import 'package:fusion_app_store/core/global/analytics_service.dart';
import 'package:fusion_app_store/core/global/status_panel.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class AppViewPageController
    extends Controller<AppViewPageState, AppViewPageEvent> {
  AppViewPageController() : super(stateMachine: AppViewPageStateMachine()) {
    _presenter = Get.find<AppViewPagePresenter>();
  }

  late final AppViewPagePresenter _presenter;

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void init(String? appID) {
    if (appID != null) {
      AnalyticsService.repository.increaseAppViewsCount(appID);
      prettyLog(value: 'Viewing $appID');
      _presenter.watchCurrentUser(
        observer: UseCaseObserver<UserEntity?>(
          name: 'GetCurrentUser:AppView',
          onNextValue: (user) {
            if (user != null) {
              _presenter.getAppByID(
                observer: UseCaseObserver<AppEntity?>(
                  name: 'GetAppByID',
                  onNextValue: (app) async {
                    if (app != null) {
                      // checking if we got an empty app entity
                      // which we get once the app is deleted from firebase or does not exists
                      if (app.maintainer.isEmpty) {
                        Get.find<RouteService>().navigateTo(
                          page: RouteService.errorPage,
                          arguments: [
                            '$appID has been removed from server',
                            'Most probably, the owner of the app has removed it.'
                          ],
                          shouldReplace: true,
                        );
                      } else {
                        // preloading icon and images
                        await preloadImages(urls: [app.icon, ...app.imageUrls]);
                        _presenter.getAppReviewsByID(
                          observer: UseCaseObserver<AppReviewEntity>(
                            name: "GetAppReviewsByID",
                            onNextValue: (review) async {
                              if (review != null) {
                                // preloading users who reviewed the app
                                final usernames = review.reviews
                                    .map((e) => e.username)
                                    .toList();
                                onEvent(AppViewPageInitializedEvent(
                                  publisher: user,
                                  appEntity: app,
                                  appReviewEntity: review,
                                  usersWhoReviewed:
                                      await Get.find<DataListener>()
                                          .instantLoadUsers(usernames),
                                  moreAppsByPublisher:
                                      await Get.find<DataListener>()
                                          .instantLoadApps(
                                              user.ownedApps.toList()
                                                ..remove(app.appID)),
                                ));
                              }
                            },
                          ),
                          appID: appID,
                        );
                      }
                    }
                  },
                ),
                appID: appID,
              );
            }
          },
        ),
      );
    } else {
      Get.find<RouteService>().navigateTo(
        page: RouteService.errorPage,
        arguments: [
          'The App id is not provided',
          'App ID is required to load this page.'
        ],
        shouldReplace: true,
      );
    }
  }

  void likeApp(bool like, AppEntity appEntity) {
    if (like) {
      _presenter.likeApp(
        observer: UseCaseObserver(
          name: 'LikeApp:#${appEntity.appID}',
        ),
        appEntity: appEntity,
      );
    } else {
      _presenter.dislikeApp(
        observer: UseCaseObserver(
          name: 'DislikeApp:#${appEntity.appID}',
        ),
        appEntity: appEntity,
      );
    }
  }

  void verifyApp(AppEntity appEntity) {
    _presenter.verifyApp(
      observer: UseCaseObserver(
        name: 'VerifyApp:#${appEntity.appID}',
      ),
      appEntity: appEntity,
    );
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

  void reviewApp(AppEntity appEntity, AppReview appReview) {
    showLoader("Posting Review ...");
    _presenter.reviewApp(
      observer: UseCaseObserver(
        name: 'ReviewApp:${appEntity.appID}',
        onFinish: () {
          // no need to do anything
          // the core will itself rebuild the page
          hideLoader();
        },
      ),
      appEntity: appEntity,
      appReview: appReview,
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
