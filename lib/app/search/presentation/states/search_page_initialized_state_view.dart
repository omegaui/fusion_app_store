import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_controller.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_states_and_events.dart';
import 'package:fusion_app_store/app/search/presentation/widgets/search_box.dart';
import 'package:fusion_app_store/app/search/presentation/widgets/searched_app_card.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/pricing_model.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/config/app_animations.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SearchPageInitializedStateView extends StatefulWidget {
  const SearchPageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
  });

  final SearchPageController controller;
  final SearchPageInitializedState state;

  @override
  State<SearchPageInitializedStateView> createState() =>
      _SearchPageInitializedStateViewState();
}

class _SearchPageInitializedStateViewState
    extends State<SearchPageInitializedStateView> {
  late String lastQuery;
  List<AppEntity> apps = [];

  late PlatformType platformType;
  String pricingType = 'Any';
  final pricingCheckBoxTitles = [
    'Any',
    ...PricingType.values.map((e) => e.name.capitalize!)
  ];

  String category = 'Any';
  final categoryCheckBoxTitles = [
    'Any',
    ...AppCategory.values.map((e) => parseAppCategory(e))
  ];

  @override
  void initState() {
    super.initState();
    platformType = widget.state.platformType;
    lastQuery = widget.state.searchQuery;
    filter();
  }

  void filter() {
    apps = [...widget.state.apps];
    // applying platform filter
    apps.retainWhere(
        (e) => e.supportedPlatforms.any((e) => e.type == platformType));
    // applying price filter
    if (pricingType != 'Any') {
      apps.retainWhere((e) =>
          e.pricingModel.type ==
          PricingType.values.byName(pricingType.toLowerCase()));
    }
    // applying category filter
    if (category != 'Any') {
      apps.retainWhere((e) =>
          e.category == AppCategory.values.byName(category.toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // managing state update
    if (lastQuery != widget.state.searchQuery) {
      filter();
      lastQuery = widget.state.searchQuery;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(120),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Filters",
                                style:
                                    AppTheme.fontSize(26).makeBold().useSen(),
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  Text(
                                    "By Platform",
                                    style: AppTheme.fontSize(16)
                                        .makeBold()
                                        .useSen(),
                                  ),
                                  const Gap(4),
                                  Text(
                                    "(${platformType.name.capitalize})",
                                    style: AppTheme.fontSize(15)
                                        .makeBold()
                                        .useSen()
                                        .withColor(Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              ...PlatformType.values.map(
                                (e) => _buildCheckBox(
                                  title: e.name.capitalize!,
                                  selected: platformType == e,
                                  onChanged: (selected) {
                                    if (selected != null && selected) {
                                      platformType = e;
                                      filter();
                                      rebuild();
                                    }
                                  },
                                ),
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  Text(
                                    "By Price",
                                    style: AppTheme.fontSize(16)
                                        .makeBold()
                                        .useSen(),
                                  ),
                                  const Gap(4),
                                  Text(
                                    "($pricingType)",
                                    style: AppTheme.fontSize(15)
                                        .makeBold()
                                        .useSen()
                                        .withColor(Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              ...pricingCheckBoxTitles.map(
                                (e) => _buildCheckBox(
                                  title: e,
                                  selected: pricingType == e,
                                  onChanged: (selected) {
                                    if (selected != null && selected) {
                                      pricingType = e;
                                      filter();
                                      rebuild();
                                    }
                                  },
                                ),
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  Text(
                                    "By Category",
                                    style: AppTheme.fontSize(16)
                                        .makeBold()
                                        .useSen(),
                                  ),
                                  const Gap(4),
                                  Text(
                                    "($category)",
                                    style: AppTheme.fontSize(15)
                                        .makeBold()
                                        .useSen()
                                        .withColor(Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const Gap(15),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    ...categoryCheckBoxTitles.map(
                                      (e) => _buildChip(
                                        title: e,
                                        selected: category == e,
                                        onChanged: (selected) {
                                          if (selected != null && selected) {
                                            category = e;
                                            filter();
                                            rebuild();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (apps.isNotEmpty)
                                ...apps.map(
                                  (e) => SearchedAppCard(
                                    app: e,
                                    controller: widget.controller,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (apps.isEmpty)
            Align(
              child: _buildEmptyState(),
            ),
          Align(
            alignment: Alignment.topCenter,
            child: _buildTopBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 320,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.square(
                    dimension: 48,
                    child: Image.asset(
                      AppIcons.appIcon,
                    ),
                  ),
                  Text(
                    "Fusion App Store",
                    style: AppTheme.fontSize(16).makeMedium().useSen(),
                  ),
                ],
              ),
            ),
            SearchBox(
              controller: widget.controller,
              state: widget.state,
              onSearch: (query) {
                widget.controller.searchApps(query, platformType);
              },
            ),
            SizedBox(
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.controller.gotoDashboard();
                    },
                    tooltip: "Open Dashboard",
                    icon: Image.network(
                      widget.state.userEntity.avatarUrl,
                      width: 32,
                      filterQuality: FilterQuality.high,
                    ),
                    iconSize: 32,
                  ),
                  const Gap(10),
                  IconButton(
                    onPressed: () {
                      widget.controller.gotoDashboard(
                        initialViewType: ViewType.ownedApps,
                      );
                    },
                    tooltip: "Your Apps",
                    icon: Icon(
                      Icons.app_registration_rounded,
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
      ),
    );
  }

  Widget _buildCheckBox({
    required String title,
    required bool selected,
    required void Function(bool? selected) onChanged,
    bool compact = false,
  }) {
    return Row(
      mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (!compact) ...[
          const Gap(40),
        ],
        Checkbox(
          value: selected,
          onChanged: onChanged,
        ),
        const Gap(4),
        Text(
          title,
          style: AppTheme.fontSize(14).makeMedium().useSen(),
        ),
      ],
    );
  }

  Widget _buildChip({
    required String title,
    required bool selected,
    required void Function(bool? selected) onChanged,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(true);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? Colors.deepPurple : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            title,
            style: AppTheme.fontSize(14)
                .makeMedium()
                .useSen()
                .withColor(selected ? Colors.white : AppTheme.foreground),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const Gap(120),
        Lottie.asset(
          AppAnimations.floating,
          width: 500,
        ),
        const Gap(20),
        Text(
          "Try out different filters and search for apps!",
          textAlign: TextAlign.center,
          style: AppTheme.fontSize(16).makeMedium().useSen(),
        ),
      ],
    );
  }

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }
}
