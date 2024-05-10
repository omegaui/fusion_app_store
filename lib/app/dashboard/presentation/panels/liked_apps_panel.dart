import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/store_app_card.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class LikedAppsPanel extends StatefulWidget {
  const LikedAppsPanel({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  @override
  State<LikedAppsPanel> createState() => _LikedAppsPanelState();
}

class _LikedAppsPanelState extends State<LikedAppsPanel> {
  List<AppEntity> apps = [];

  @override
  Widget build(BuildContext context) {
    apps = widget.state.likedApps;
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
                        colors: [
                          Colors.red,
                          Colors.redAccent,
                        ],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Liked Apps",
                      style: AppTheme.fontSize(42).makeMedium(),
                    ),
                  ],
                ),
                const Gap(10),
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
                              (e) => StoreAppCard(
                                app: e,
                                onPressed: () {
                                  widget.controller.viewApp(e);
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
