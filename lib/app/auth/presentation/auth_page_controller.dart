import 'package:fusion_app_store/app/auth/presentation/auth_page_presenter.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_state_machine.dart.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_states_and_machine.dart.dart';
import 'package:fusion_app_store/app/auth/presentation/dialogs/terms_of_service_dialog.dart';
import 'package:fusion_app_store/core/global/status_panel.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class AuthPageController extends Controller<AuthPageState, AuthPageEvent> {
  AuthPageController() : super(stateMachine: AuthPageStateMachine()) {
    _presenter = Get.find<AuthPagePresenter>();
  }

  late final AuthPagePresenter _presenter;

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void checkLogin() {
    _presenter.findUserLoginStatus(
      observer: UseCaseObserver<bool>(
        name: "UserLoginStatus",
        onNextValue: (loggedIn) {
          if ((loggedIn ?? false)) {
            Get.find<RouteService>().navigateTo(
              page: RouteService.onBoardingPage,
              shouldReplace: true,
            );
          } else {
            onEvent(AuthPageInitializedEvent());
          }
        },
      ),
    );
  }

  void loginWithGoogle() {
    showLoader("Sign In with Google");
    _presenter.performLoginWithGoogle(
      observer: UseCaseObserver<bool>(
        name: "GoogleSignIn",
        onNextValue: (loggedIn) {
          hideLoader();
          if (loggedIn ?? false) {
            _presenter.isNewlyJoined(
              observer: UseCaseObserver<bool>(
                name: "UserJoinState:$loggedIn",
                onNextValue: (newbie) {
                  if (!newbie!) {
                    TermsOfServiceDialog.open(
                      _startOnBoarding,
                      _logOut,
                    );
                  } else {
                    _startOnBoarding();
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  void _logOut() {
    _presenter.logOut(
      observer: UseCaseObserver<bool>(
        name: "UserLogOut",
        onNextValue: (loggedOut) {
          if (loggedOut!) {
            Get.find<RouteService>().navigateTo(
              page: RouteService.homePage,
              shouldReplace: true,
            );
          }
        },
      ),
    );
  }

  void _startOnBoarding() {
    Get.find<RouteService>().navigateTo(
      page: RouteService.onBoardingPage,
      shouldReplace: true,
    );
  }
}
