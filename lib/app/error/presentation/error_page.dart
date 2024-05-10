import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/error/presentation/error_page_controller.dart';
import 'package:fusion_app_store/app/error/presentation/error_page_states_and_events.dart';
import 'package:fusion_app_store/app/error/presentation/states/error_page_identification_state_view.dart';
import 'package:fusion_app_store/app/error/presentation/states/error_page_identified_state_view.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class ErrorPage extends AppPage {
  const ErrorPage({super.key});

  @override
  State<StatefulWidget> createState() => _ErrorPage();
}

class _ErrorPage extends ResponsiveViewState<ErrorPage, ErrorPageController> {
  _ErrorPage() : super(ErrorPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<ErrorPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (ErrorIdentificationState):
            controller.identifyError();
            return const ErrorPageIdentificationStateView();
          case const (ErrorIdentifiedState):
            return ErrorPageIdentifiedStateView(
              state: currentState as ErrorIdentifiedState,
              deviceType: DeviceType.desktop,
            );
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get mobileView {
    return ControlledWidgetBuilder<ErrorPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (ErrorIdentificationState):
            controller.identifyError();
            return const ErrorPageIdentificationStateView();
          case const (ErrorIdentifiedState):
            return ErrorPageIdentifiedStateView(
              state: currentState as ErrorIdentifiedState,
              deviceType: DeviceType.mobile,
            );
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get tabletView {
    return ControlledWidgetBuilder<ErrorPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (ErrorIdentificationState):
            controller.identifyError();
            return const ErrorPageIdentificationStateView();
          case const (ErrorIdentifiedState):
            return ErrorPageIdentifiedStateView(
              state: currentState as ErrorIdentifiedState,
              deviceType: DeviceType.tablet,
            );
        }
        throw Exception("UnrecognizedStateException: $currentState}");
      },
    );
  }

  @override
  Widget get watchView => throw UnimplementedError();
}
