import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_controller.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_states_and_events.dart';
import 'package:fusion_app_store/app/onboarding/presentation/states/onboarding_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/onboarding/presentation/states/onboarding_page_loading_state_view.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class OnBoardingPage extends AppPage {
  const OnBoardingPage({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState
    extends ResponsiveViewState<OnBoardingPage, OnBoardingPageController> {
  _OnBoardingPageState() : super(OnBoardingPageController());

  Widget _buildView(DeviceType deviceType) {
    return ControlledWidgetBuilder<OnBoardingPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (OnBoardingPageLoadingState):
            controller.checkNewJoin(deviceType);
            return const OnBoardingPageLoadingStateView();
          case const (OnBoardingPageInitializedState):
            return OnBoardingPageInitializedStateView(
              controller: controller,
              state: currentState as OnBoardingPageInitializedState,
            );
        }
        gotoErrorPage(
            "Unknown OnBoarding State", "${currentState.runtimeType}");
        throw Exception();
      },
    );
  }

  @override
  Widget get desktopView {
    return _buildView(DeviceType.desktop);
  }

  @override
  Widget get mobileView {
    return _buildView(DeviceType.mobile);
  }

  @override
  Widget get tabletView {
    return _buildView(DeviceType.tablet);
  }

  @override
  Widget get watchView => throw UnimplementedError();
}
