import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_presenter.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_state_machine.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_states_and_events.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class UserViewPageController
    extends Controller<UserViewPageState, UserViewPageEvent> {
  UserViewPageController() : super(stateMachine: UserViewPageStateMachine()) {
    _presenter = Get.find<UserViewPagePresenter>();
  }

  late final UserViewPagePresenter _presenter;

  @override
  void initListeners() {}

  void init(String? id) {
    if (id != null) {
      _presenter.findUser(
        id: id,
        observer: UseCaseObserver<UserEntity?>(
          name: "FindUser:$id:",
          onNextValue: (user) {
            if (user == null) {
              onEvent(UserViewPageNotFoundEvent());
            } else {
              _presenter.getAppsByUser(
                user: user,
                observer: UseCaseObserver<List<AppEntity>>(
                  name: "GetAppsByUser:${user.username}",
                  onNextValue: (apps) async {
                    if (apps != null) {
                      await preloadImage(url: user.avatarUrl);
                      onEvent(
                        UserViewPageInitializedEvent(
                          user: user,
                          apps: apps,
                        ),
                      );
                    }
                  },
                ),
              );
            }
          },
        ),
      );
    } else {
      Get.find<RouteService>().navigateTo(
        page: RouteService.errorPage,
        arguments: [
          'The User id is not provided',
          'User ID (username) is required to load this page.'
        ],
        shouldReplace: true,
      );
    }
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
