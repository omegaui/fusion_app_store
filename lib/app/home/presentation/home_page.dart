import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_states_and_events.dart';
import 'package:fusion_app_store/app/home/presentation/states/home_page_initialized_desktop_state_view.dart';
import 'package:fusion_app_store/app/home/presentation/states/home_page_initialized_mobile_state_view.dart';
import 'package:fusion_app_store/app/home/presentation/states/home_page_initialized_tablet_state_view.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class HomePage extends AppPage {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ResponsiveViewState<HomePage, HomePageController> {
  _HomePageState() : super(HomePageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<HomePageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState().runtimeType;
        switch (currentState) {
          case const (HomePageInitializedState):
            return HomePageInitializedDesktopStateView(controller: controller);
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<HomePageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState().runtimeType;
        switch (currentState) {
          case const (HomePageInitializedState):
            return HomePageInitializedMobileStateView(controller: controller);
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get tabletView {
    return ControlledWidgetBuilder<HomePageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState().runtimeType;
        switch (currentState) {
          case const (HomePageInitializedState):
            return HomePageInitializedTabletStateView(controller: controller);
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get watchView => throw UnimplementedError();
}
