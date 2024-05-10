import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/error/presentation/error_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ErrorPageIdentifiedStateView extends StatelessWidget {
  const ErrorPageIdentifiedStateView({
    super.key,
    required this.state,
    required this.deviceType,
  });

  final ErrorIdentifiedState state;
  final DeviceType deviceType;

  Widget _buildHeader() {
    if (deviceType == DeviceType.mobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Oops!",
            style: AppTheme.fontSize(102),
          ),
          const Gap(20),
          Text(
            "An internal error",
            style: AppTheme.fontSize(36),
          ),
          Text(
            "has occurred.",
            style: AppTheme.fontSize(36),
          )
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Oops!",
          style: AppTheme.fontSize(102),
        ),
        const Gap(20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "An internal error",
              style: AppTheme.fontSize(36),
            ),
            Text(
              "has occurred.",
              style: AppTheme.fontSize(36),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(),
            const Gap(30),
            Text(
              "We have recorded what went wrong,\nPlease click report issue to let the team know about it.",
              textAlign: TextAlign.center,
              style: AppTheme.fontSize(20),
            ),
            const Gap(30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CoreAppButton(
                  text: "Report Issue",
                  icon: Icon(
                    Icons.bug_report_outlined,
                    color: AppTheme.foreground,
                  ),
                  onPressed: () {
                    launchUrlString('https://github.com/omegaui/fusion_app_store/issues/new');
                  },
                ),
                const Gap(15),
                CoreAppButton(
                  text: "Go to Home Page",
                  icon: Icon(
                    Icons.home_filled,
                    color: AppTheme.foreground,
                  ),
                  onPressed: () {
                    Get.find<RouteService>()
                        .navigateTo(page: RouteService.homePage);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
