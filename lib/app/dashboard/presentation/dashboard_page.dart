import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/dashboard_page_loading_state_view.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class DashboardPage extends AppPage {
  const DashboardPage({
    super.key,
    required this.arguments,
  });

  final DashboardPageArguments? arguments;

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage
    extends ResponsiveViewState<DashboardPage, DashboardPageController> {
  _DashboardPage() : super(DashboardPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<DashboardPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (DashboardPageLoadingState):
            controller.checkLogin(widget.arguments);
            return const DashboardPageLoadingStateView();
          case const (DashboardPageInitializedState):
            return DesktopDashboardPageInitializedStateView(
              controller: controller,
              state: currentState as DashboardPageInitializedState,
            );
        }
        gotoErrorPage("Unknown Dashboard State", "${currentState.runtimeType}");
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
