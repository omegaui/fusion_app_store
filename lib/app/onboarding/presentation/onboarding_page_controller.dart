import 'package:flutter/cupertino.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_presenter.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_state_machine.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/domain/arguments/store_page_arguments.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/core/global/status_panel.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class OnBoardingPageController
    extends Controller<OnBoardingPageState, OnBoardingPageEvent> {
  final OnBoardingPagePresenter _presenter =
      Get.find<OnBoardingPagePresenter>();

  OnBoardingPageController() : super(stateMachine: OnBoardingStateMachine());

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void logOut() {
    showLoader("Going back to authentication ...");
    _presenter.logout(
      observer: UseCaseObserver(
        name: "UserLogout",
        onNextValue: (loggedOut) {
          hideLoader();
          if (loggedOut) {
            Get.find<RouteService>().navigateTo(page: RouteService.authPage);
          }
        },
      ),
    );
  }

  void isUsernameAvailable(String username, DeviceType deviceType,
      {VoidCallback? onSuccess}) {
    _presenter.checkIfUsernameAvailable(
      username: username,
      observer: UseCaseObserver<bool>(
        name: "UsernameAvailable",
        onNextValue: (usernameAvailable) {
          onEvent(OnBoardingPageInitializedEvent(
            usernameAvailable: usernameAvailable,
            deviceType: deviceType,
          ));
          if (onSuccess != null) {
            onSuccess();
          }
        },
      ),
    );
  }

  void addUser(UserEntity userEntity, DeviceType deviceType) {
    // there is a chance that user can go back in steps
    // and edit its username, so to ensure normalization,
    // we will again check that if the username is available.
    showLoader("Validating Your Fusion Account");
    _presenter.checkIfUsernameAvailable(
      username: userEntity.username,
      observer: UseCaseObserver<bool>(
        name: "UsernameAvailable",
        onNextValue: (usernameAvailable) {
          if (!usernameAvailable!) {
            hideLoader();
            onEvent(OnBoardingPageInitializedEvent(
              usernameAvailable: usernameAvailable,
              deviceType: deviceType,
            ));
          } else {
            showLoader("Taking you to the Store");
            _presenter.updateUser(
              userEntity: userEntity,
              observer: UseCaseObserver<void>(
                name: "AddNewUser",
                onFinish: () {
                  Get.find<RouteService>().navigateTo(
                    page: RouteService.storePage,
                    arguments: StorePageArguments(
                        isOnBoarded: true, isUserLoggedIn: true),
                  );
                  hideLoader();
                },
              ),
            );
          }
        },
      ),
    );
  }

  void checkNewJoin(DeviceType deviceType) {
    _presenter.isNewlyJoined(
      observer: UseCaseObserver<bool>(
        name: "NewUser",
        onNextValue: (newlyJoined) {
          if (newlyJoined!) {
            onEvent(OnBoardingPageInitializedEvent(deviceType: deviceType));
          } else {
            Get.find<RouteService>().navigateTo(
              page: RouteService.storePage,
              arguments: StorePageArguments(
                isOnBoarded: true,
                isUserLoggedIn: true,
              ),
            );
          }
        },
      ),
    );
  }
}
