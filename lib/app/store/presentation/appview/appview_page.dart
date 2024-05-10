import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_loading_state_view.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';
import 'package:get/get.dart';

class AppViewPage extends AppPage {
  const AppViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppViewPageState();
}

class _AppViewPageState
    extends ResponsiveViewState<AppViewPage, AppViewPageController> {
  _AppViewPageState() : super(AppViewPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<AppViewPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (AppViewPageLoadingState):
            String? id = Get.parameters['id'];
            controller.init(id);
            return const AppViewPageLoadingStateView();
          case const (AppViewPageInitializedState):
            return AppViewPageInitializedStateView(
              controller: controller,
              state: currentState as AppViewPageInitializedState,
              deviceType: DeviceType.desktop,
            );
        }
        gotoErrorPage("Unknown Store State", "${currentState.runtimeType}");
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
