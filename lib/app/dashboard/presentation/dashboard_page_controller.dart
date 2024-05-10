import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_presenter.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_state_machine.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/create_app_wizard.dart';
import 'package:fusion_app_store/app/dashboard/presentation/wizards/desktop/edit_app_wizard.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/arguments/store_page_arguments.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/core/global/message_box.dart';
import 'package:fusion_app_store/core/global/status_panel.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class DashboardPageController
    extends Controller<DashboardPageState, DashboardPageEvent> {
  DashboardPageController() : super(stateMachine: DashboardStateMachine()) {
    _presenter = Get.find<DashboardPagePresenter>();
  }

  late final DashboardPagePresenter _presenter;
  DashboardPageArguments? arguments;

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void _initialize() {
    _presenter.watchCurrentUser(
      observer: UseCaseObserver<UserEntity>(
        name: "GetCurrentUser",
        onNextValue: (userEntity) {
          if (userEntity != null) {
            _presenter.watchLikedApps(
              observer: UseCaseObserver<List<AppEntity>>(
                name: 'WatchLikedApps:${userEntity.username}',
                onNextValue: (likedApps) {
                  _presenter.watchReviewedApps(
                    observer: UseCaseObserver<List<AppEntity>>(
                      name: 'WatchReviewedApps:${userEntity.username}',
                      onNextValue: (reviewedApps) {
                        _presenter.watchAppsByUser(
                          username: userEntity.username,
                          observer: UseCaseObserver<List<AppEntity>>(
                            name: "WatchAppsByUser",
                            onNextValue: (ownedApps) async {
                              final isPremiumUser =
                                  await checkUserSubscription();
                              onEvent(
                                DashboardPageInitializedEvent(
                                  userEntity: userEntity,
                                  ownedApps: ownedApps!,
                                  likedApps: likedApps!,
                                  reviewedApps: reviewedApps!,
                                  initialViewType: arguments?.initialViewType,
                                  isPremiumUser: isPremiumUser,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    appIDs: userEntity.reviewedApps.toList(),
                  );
                },
              ),
              appIDs: userEntity.likedApps.toList(),
            );
          }
        },
      ),
    );
  }

  void checkLogin(DashboardPageArguments? arguments) {
    this.arguments = arguments;
    bool isOnBoarded = arguments?.isOnBoarded ?? false;
    if (isOnBoarded) {
      _initialize();
    } else {
      _presenter.findUserLoginStatus(
        observer: UseCaseObserver<bool>(
          name: "UserLoginStatus",
          onNextValue: (loggedIn) {
            if ((loggedIn ?? false)) {
              _checkNewJoin();
            } else {
              _initialize();
            }
          },
        ),
      );
    }
  }

  void _checkNewJoin() {
    _presenter.isNewlyJoined(
      observer: UseCaseObserver<bool>(
        name: "NewUser",
        onNextValue: (newlyJoined) {
          if (newlyJoined!) {
            Get.find<RouteService>().navigateTo(
              page: RouteService.onBoardingPage,
              shouldReplace: true,
            );
          } else {
            _initialize();
          }
        },
      ),
    );
  }

  void uploadApp(AppEntity appEntity) {
    _presenter.uploadApp(
      appEntity: appEntity,
      observer: UseCaseObserver(
        name: "UploadApp",
      ),
    );
  }

  void logOut() {
    _presenter.logOut(
      observer: UseCaseObserver<bool>(
        name: "UserLogOut",
        onNextValue: (loggedOut) {
          if (loggedOut!) {
            Get.find<RouteService>().navigateTo(
              page: RouteService.authPage,
              shouldReplace: true,
            );
          }
        },
      ),
    );
  }

  void gotoStore() {
    Get.find<RouteService>().navigateTo(
      page: RouteService.storePage,
      arguments: StorePageArguments(
        isOnBoarded: true,
        isUserLoggedIn: true,
      ),
      shouldReplace: true,
    );
  }

  void createApp(DashboardPageInitializedState state) {
    if (isUserProfileComplete(state.userEntity)) {
      CreateAppWizard.open(this, state);
    } else {
      showMessage(
        title: "Please complete your profile",
        description:
            "You cannot publish an app until you have provided the your website, privacy policy, address and terms & conditions.",
      );
    }
  }

  void editApp(
      DashboardPageInitializedState state, AppEntity initialAppEntity) {
    EditAppWizard.open(this, state, initialAppEntity);
  }

  void viewApp(AppEntity app) {
    Get.find<RouteService>().navigateTo(
      page: RouteService.appPage,
      parameters: {
        'id': app.appID,
      },
    );
  }

  void deleteApp(AppEntity appEntity) {
    showLoader("Deleting ${appEntity.name}");
    _presenter.deleteApp(
      appEntity: appEntity,
      observer: UseCaseObserver(
        name: "DeleteApp",
        onFinish: () {
          hideLoader();
        },
      ),
    );
  }

  void updateUser(UserEntity userEntity) {
    showLoader("Updating your profile");
    _presenter.updateUser(
      userEntity: userEntity,
      observer: UseCaseObserver<void>(
        name: "UpdateUserProfile",
        onFinish: () {
          hideLoader();
        },
      ),
    );
  }

  void updateSubscription(DashboardPageInitializedState state) {
    onEvent(
      DashboardPageInitializedEvent(
        userEntity: state.userEntity,
        ownedApps: state.ownedApps,
        likedApps: state.likedApps,
        reviewedApps: state.reviewedApps,
        isPremiumUser: true,
      ),
    );
  }
}
