import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_controller.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

import 'store_app_card.dart';

class AppsPanel extends StatefulWidget {
  const AppsPanel({
    super.key,
    required this.apps,
    required this.heading,
    required this.controller,
  });

  final List<AppEntity> apps;
  final String heading;
  final StorePageController controller;

  @override
  State<AppsPanel> createState() => _AppsPanelState();
}

class _AppsPanelState extends State<AppsPanel> {
  List<AppEntity> apps = [];

  @override
  Widget build(BuildContext context) {
    apps =
        widget.apps.where((e) => e.headings.contains(widget.heading)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: SizedBox(
        width: 1300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.heading,
                  style: AppTheme.fontSize(24).makeBold(),
                ),
                IconButton(
                  onPressed: () {},
                  tooltip: 'View All',
                  icon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  ...apps.map((e) {
                    return StoreAppCard(
                      app: e,
                      onPressed: () {
                        widget.controller.viewApp(e);
                      },
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
