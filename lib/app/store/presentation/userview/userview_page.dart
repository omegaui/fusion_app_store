import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/presentation/userview/states/userview_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/userview/states/userview_page_loading_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/userview/states/userview_page_not_found_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_states_and_events.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';
import 'package:get/get.dart';

class UserViewPage extends AppPage {
  const UserViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserViewPageState();
}

class _UserViewPageState
    extends ResponsiveViewState<UserViewPage, UserViewPageController> {
  _UserViewPageState() : super(UserViewPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<UserViewPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (UserViewPageLoadingState):
            String? id = Get.parameters['id'];
            controller.init(id);
            return const UserViewPageLoadingStateView();
          case const (UserViewPageNotFoundState):
            return const UserViewPageNotFoundStateView();
          case const (UserViewPageInitializedState):
            return UserViewPageInitializedStateView(
              controller: controller,
              state: currentState as UserViewPageInitializedState,
            );
        }
        gotoErrorPage("Unknown UserView State", "${currentState.runtimeType}");
        throw Exception();
      },
    );
  }

  @override
  Widget get mobileView => throw UnimplementedError();

  @override
  Widget get tabletView => throw UnimplementedError();

  @override
  Widget get watchView => throw UnimplementedError();
}
