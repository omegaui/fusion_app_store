import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_controller.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_states_and_events.dart';
import 'package:fusion_app_store/app/search/presentation/states/search_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/search/presentation/states/search_page_loading_state_view.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/machine/page.dart';
import 'package:get/get.dart';

class SearchPage extends AppPage {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState
    extends ResponsiveViewState<SearchPage, SearchPageController> {
  _SearchPageState() : super(SearchPageController());

  @override
  Widget get desktopView {
    return ControlledWidgetBuilder<SearchPageController>(
      builder: (context, controller) {
        final currentState = controller.getCurrentState();
        switch (currentState.runtimeType) {
          case const (SearchPageLoadingState):
            final parameters = Get.parameters;
            controller.init(parameters['query']!, parameters['platform']!);
            return const SearchPageLoadingStateView();
          case const (SearchPageInitializedState):
            return SearchPageInitializedStateView(
              controller: controller,
              state: currentState as SearchPageInitializedState,
            );
        }
        gotoErrorPage("Unknown Search State", "${currentState.runtimeType}");
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
