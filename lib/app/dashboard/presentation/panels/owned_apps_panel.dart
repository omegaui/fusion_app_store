import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/widgets/dashboard_app_card.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/sorting_mode.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OwnedAppsPanel extends StatefulWidget {
  const OwnedAppsPanel({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  @override
  State<OwnedAppsPanel> createState() => _OwnedAppsPanelState();
}

class _OwnedAppsPanelState extends State<OwnedAppsPanel> {
  // List of Apps
  List<AppEntity> apps = [];

  // Searching
  TextEditingController editingController = TextEditingController();

  // Sorting Modes
  SortingMode sortingMode = SortingMode.newest;
  String searchText = "";

  // Platform Filter
  String platformType = "Any";
  final platforms = [
    "Any",
    ...PlatformType.values.map((e) => e.name.capitalize!)
  ];

  @override
  Widget build(BuildContext context) {
    apps = widget.state.ownedApps;
    // Filtering
    if (platformType == "Any") {
      apps = widget.state.ownedApps;
    } else {
      apps = widget.state.ownedApps
          .where((e) => e.supportedPlatforms.any((element) =>
              element.type.name.isCaseInsensitiveContains(platformType)))
          .toList();
    }
    // Sorting
    switch (sortingMode) {
      case SortingMode.newest:
        apps.sort((a, b) => b.publishedOn.compareTo(a.publishedOn));
        break;
      case SortingMode.oldest:
        apps.sort((a, b) => a.publishedOn.compareTo(b.publishedOn));
        break;
      case SortingMode.aToZ:
        apps.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortingMode.zToA:
        apps.sort((a, b) => b.name.compareTo(a.name));
    }
    // then, Searching on left apps
    apps = apps
        .where((e) => e.name.isCaseInsensitiveContains(searchText))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.cyan],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.app_registration_rounded,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Owned Apps",
                      style: AppTheme.fontSize(42).makeMedium(),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(10),
                    CoreAppButton(
                      text: "Create App",
                      icon: Icon(
                        Icons.add,
                        color: AppTheme.dashboardCardTextColor,
                      ),
                      onPressed: () {
                        widget.controller.createApp(widget.state);
                      },
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Container(
                        width: 550,
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormField(
                                autofocus: true,
                                controller: editingController,
                                style: AppTheme.fontSize(14).makeMedium(),
                                decoration: InputDecoration(
                                  hintText: "Search apps by name ...",
                                  hintStyle: AppTheme.fontSize(14)
                                      .withColor(Colors.grey),
                                  prefixIcon: Icon(
                                    apps.isEmpty ? Icons.close : Icons.search,
                                    color: apps.isEmpty
                                        ? Colors.red
                                        : AppTheme.foreground,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchText = value;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Sort by: ",
                                  style: AppTheme.fontSize(12).makeMedium(),
                                ),
                                const Gap(4),
                                DropdownButton<SortingMode>(
                                  value: sortingMode,
                                  items: SortingMode.values
                                      .map((e) => DropdownMenuItem<SortingMode>(
                                            value: e,
                                            child: Text(
                                              e.name.capitalize!,
                                              style: AppTheme.fontSize(12)
                                                  .makeMedium(),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      sortingMode = value!;
                                    });
                                  },
                                ),
                                const Gap(15),
                                Text(
                                  "Platform :",
                                  style: AppTheme.fontSize(12).makeMedium(),
                                ),
                                const Gap(4),
                                DropdownButton<String>(
                                  value: platformType,
                                  items: platforms
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: AppTheme.fontSize(12)
                                                  .makeMedium(),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      platformType = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                if (apps.isEmpty) ...[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(100),
                        SizedBox(
                          height: 256,
                          child: Image.network(
                            "https://img.icons8.com/external-basicons-color-danil-polshin/256/external-space-space-basicons-color-danil-polshin-16.png",
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "You app library is empty.",
                          textAlign: TextAlign.center,
                          style: AppTheme.fontSize(18).useSen().makeBold(),
                        ),
                        Text(
                          "Create, import or upload the app config to add your apps.",
                          textAlign: TextAlign.center,
                          style: AppTheme.fontSize(18).useSen().makeMedium(),
                        ),
                      ],
                    ),
                  ),
                ],
                if (apps.isNotEmpty) ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Wrap(
                          spacing: 25,
                          runSpacing: 25,
                          children: [
                            ...apps.map(
                              (e) => DashboardAppCard(
                                appEntity: e,
                                controller: widget.controller,
                                onPressed: () {
                                  widget.controller.editApp(widget.state, e);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
