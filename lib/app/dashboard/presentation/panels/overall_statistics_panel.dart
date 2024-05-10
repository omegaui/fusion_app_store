import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/analytics/domain/entities/app_analytics_entity.dart';
import 'package:fusion_app_store/app/analytics/domain/repository/analytics_repository.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dialogs/payments_dialog.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_artworks.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OverallStatisticsPanel extends StatefulWidget {
  const OverallStatisticsPanel({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  @override
  State<OverallStatisticsPanel> createState() => _OverallStatisticsPanelState();
}

class _OverallStatisticsPanelState extends State<OverallStatisticsPanel> {
  bool loaded = false;
  int totalAppViews = 0;
  int totalSharesViews = 0;
  int totalDownloadsViews = 0;
  int totalReviews = 0;
  int totalLikes = 0;

  @override
  void initState() {
    super.initState();
    if (widget.state.isPremiumUser) {
      Future(() async {
        final db = Get.find<FusionDatabase>();
        final analyticsRepo = Get.find<AnalyticsRepository>();
        final analyticsJobs = <Future>[];
        final analyticsData = <AppAnalyticsEntity>[];

        Future<void> load(String appID) async {
          analyticsData.add(await analyticsRepo.getAnalyticsData(appID));
        }

        final apps =
            await db.getApps(widget.state.userEntity.ownedApps.toList());
        for (final app in apps) {
          analyticsJobs.add(load(app.appID));
        }
        await Future.wait(analyticsJobs);

        for (final data in analyticsData) {
          totalAppViews += data.viewsAnalytics.length;
          totalReviews += data.reviewsAnalytics.length;
          totalLikes += data.likesAnalytics.length;
          totalSharesViews += data.sharesAnalytics.length;
          totalDownloadsViews += data.downloadsAnalytics.length;
        }

        setState(() {
          loaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        colors: [Colors.pink, Colors.indigoAccent],
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.style_rounded,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Overall Statistics",
                      style: AppTheme.fontSize(42).makeMedium(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!widget.state.isPremiumUser)
            Align(
              child: Column(
                children: [
                  Image.asset(
                    AppArtWorks.premium,
                    width: 700,
                  ),
                  AppButton(
                    text: "Buy Premium",
                    onPressed: () {
                      showPaymentsDialog(
                        context,
                        () {
                          widget.controller.updateSubscription(widget.state);
                        },
                      );
                    },
                  ),
                  const Gap(10),
                  Text(
                    "To explore your growth on the platform with per pixel breakdown of\nanalytics in forms of charts and graphs, that eventually\nhelp you in planning your way to get more from the platform.",
                    textAlign: TextAlign.center,
                    style: AppTheme.fontSize(14).makeMedium(),
                  ),
                ],
              ),
            ),
          if (widget.state.isPremiumUser && !loaded)
            const Align(
              child: CircularProgressIndicator(),
            ),
          if (widget.state.isPremiumUser && loaded)
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(200),
                  Text(
                    "Total App Views: $totalAppViews",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                  Text(
                    "Total Reviews: $totalReviews",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                  Text(
                    "Total Downloads: $totalDownloadsViews",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                  Text(
                    "Total Likes: $totalLikes",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                  Text(
                    "Total Shares: $totalSharesViews",
                    style: AppTheme.fontSize(16).makeMedium(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
