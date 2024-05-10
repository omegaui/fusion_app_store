import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/store/domain/arguments/store_page_arguments.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/app/store/presentation/store/states/desktop_store_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/store/states/store_page_loading_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_states_and_events.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';

class StorePage extends AppPage {
  const StorePage({super.key, required this.arguments});

  final StorePageArguments arguments;

  @override
  State<StatefulWidget> createState() => _StorePage();
}

class _StorePage extends ResponsiveViewState<StorePage, StorePageController> {
  _StorePage() : super(StorePageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<StorePageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (StorePageLoadingState):
            controller.init(widget.arguments);
            return const StorePageLoadingStateView();
          case const (StorePageInitializedState):
            return DesktopStorePageInitializedStateView(
              controller: controller,
              state: currentState as StorePageInitializedState,
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
