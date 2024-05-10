import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_controller.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_states_and_machine.dart.dart';
import 'package:fusion_app_store/app/auth/presentation/states/auth_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/auth/presentation/states/auth_page_loading_state_view.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class AuthPage extends AppPage {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ResponsiveViewState<AuthPage, AuthPageController> {
  _AuthPageState() : super(AuthPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<AuthPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (AuthPageLoadingState):
            controller.checkLogin();
            return const AuthPageLoadingStateView();
          case const (AuthPageInitializedState):
            return AuthPageInitializedStateView(
              controller: controller,
              deviceType: DeviceType.desktop,
            );
        }
        gotoErrorPage(
            "Unknown Authentication State", "${currentState.runtimeType}");
        throw Exception();
      },
    );
  }

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<AuthPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (AuthPageLoadingState):
            controller.checkLogin();
            return const AuthPageLoadingStateView();
          case const (AuthPageInitializedState):
            return AuthPageInitializedStateView(
              controller: controller,
              deviceType: DeviceType.mobile,
            );
        }
        gotoErrorPage(
            "Unknown Authentication State", "${currentState.runtimeType}");
        throw Exception();
      },
    );
  }

  @override
  Widget get tabletView {
    return ControlledWidgetBuilder<AuthPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (AuthPageLoadingState):
            controller.checkLogin();
            return const AuthPageLoadingStateView();
          case const (AuthPageInitializedState):
            return AuthPageInitializedStateView(
              controller: controller,
              deviceType: DeviceType.tablet,
            );
        }
        gotoErrorPage(
            "Unknown Authentication State", "${currentState.runtimeType}");
        throw Exception();
      },
    );
  }

  @override
  Widget get watchView => throw UnimplementedError();
}
