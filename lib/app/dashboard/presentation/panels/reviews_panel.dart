import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/store_app_card.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class ReviewsPanel extends StatefulWidget {
  const ReviewsPanel({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  @override
  State<ReviewsPanel> createState() => _ReviewsPanelState();
}

class _ReviewsPanelState extends State<ReviewsPanel> {
  @override
  Widget build(BuildContext context) {
    final apps = widget.state.reviewedApps;
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
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.redAccent,
                          Colors.yellow.shade900,
                        ],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.rate_review,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Apps you Reviewed",
                      style: AppTheme.fontSize(42).makeMedium(),
                    ),
                  ],
                ),
                const Gap(10),
                Text(
                  "All the apps that you have reviewed will appear here for a quick navigation.",
                  style: AppTheme.fontSize(14).makeMedium(),
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
