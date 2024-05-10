import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/apps_panel.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/store_top_bar.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DesktopStorePageInitializedStateView extends StatefulWidget {
  const DesktopStorePageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
    required this.deviceType,
  });

  final StorePageController controller;
  final StorePageInitializedState state;
  final DeviceType deviceType;

  @override
  State<DesktopStorePageInitializedStateView> createState() =>
      _DesktopStorePageInitializedStateViewState();
}

class _DesktopStorePageInitializedStateViewState
    extends State<DesktopStorePageInitializedStateView> {
  final scrollController = ScrollController();
  Set<String> headings = {};

  @override
  Widget build(BuildContext context) {
    headings.clear();
    for (final app in widget.state.apps) {
      headings.addAll(app.headings);
    }
    if (headings.contains('Others')) {
      headings.remove('Others');
      headings.add('Others');
    }
    return Scaffold(
      backgroundColor: AppTheme.storeBackground,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  const Gap(100),
                  ...headings.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: AppsPanel(
                        apps: widget.state.apps,
                        heading: e,
                        controller: widget.controller,
                      ),
                    );
                  }),
                  const Gap(100),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: StoreTopBar(
              controller: widget.controller,
              state: widget.state,
              deviceType: widget.deviceType,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
