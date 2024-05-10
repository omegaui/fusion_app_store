import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/top_category_panel.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/sorting_mode.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:gap/gap.dart';

class StoreTopBar extends StatefulWidget {
  const StoreTopBar({
    super.key,
    required this.controller,
    required this.state,
    required this.deviceType,
    required this.scrollController,
  });

  final StorePageController controller;
  final StorePageInitializedState state;
  final DeviceType deviceType;
  final ScrollController scrollController;

  @override
  State<StoreTopBar> createState() => _StoreTopBarState();
}

class _StoreTopBarState extends State<StoreTopBar> {
  // searching
  final searchTextController = TextEditingController();

  // Sorting Modes
  SortingMode sortingMode = SortingMode.newest;

  // Platform Filter
  late PlatformType platformType;
  final platforms = <PlatformType>[];

  // Category Mode
  String currentCategory = "Any";
  final categories = [
    "Any",
    ...AppCategory.values.map((e) => parseAppCategory(e)),
  ];

  Widget _buildNavPanel() {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: Image.asset(
              AppIcons.appIcon,
              width: 96,
            ),
          ),
          Text(
            "Fusion App Store",
            style: AppTheme.fontSize(26)
                .makeMedium()
                .withColor(Colors.grey.shade700),
          ),
          const Gap(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StoreTopCategoryPanel(controller: widget.controller),
              const Gap(20),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.state.userEntity != null) ...[
                  IconButton(
                    onPressed: () {
                      widget.controller.gotoDashboard();
                    },
                    tooltip: "Open Dashboard",
                    icon: Image.network(
                      widget.state.userEntity!.avatarUrl,
                      width: 32,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const Gap(10),
                  IconButton(
                    onPressed: () {
                      widget.controller
                          .gotoDashboard(initialViewType: ViewType.ownedApps);
                    },
                    tooltip: "Your Apps",
                    icon: Icon(
                      Icons.app_registration_rounded,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
                if (widget.state.userEntity == null) ...[
                  CoreAppButton(
                    text: "Login",
                    onPressed: () {},
                  ),
                ],
                const Gap(10),
                IconButton(
                  onPressed: () {
                    widget.controller.gotoSearch();
                  },
                  tooltip: "Search",
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey.shade700,
                  ),
                ),
                // const Gap(10),
                // IconButton(
                //   onPressed: () {},
                //   tooltip: "Notifications",
                //   icon: Icon(
                //     Icons.notifications_active_outlined,
                //     color: Colors.grey.shade700,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInSine,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildNavPanel(),
    );
  }
}
