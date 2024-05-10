import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DashboardAppCard extends StatefulWidget {
  const DashboardAppCard({
    super.key,
    required this.appEntity,
    required this.onPressed,
    required this.controller,
  });

  final AppEntity appEntity;
  final DashboardPageController controller;
  final VoidCallback onPressed;

  @override
  State<DashboardAppCard> createState() => _DashboardAppCardState();
}

class _DashboardAppCardState extends State<DashboardAppCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: FittedBox(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (e) => setState(() => hover = true),
          onExit: (e) => setState(() => hover = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 250,
            height: 200,
            decoration: BoxDecoration(
              color: hover ? AppTheme.categoryBackground : AppTheme.background,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.curvedTopBarDropShadowColor,
                  blurRadius: 16,
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Image.asset(
                      getEsrbRatingIcon(widget.appEntity.esrbRating),
                      width: 48,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: hover ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: IconButton(
                        onPressed: () {
                          widget.controller.viewApp(widget.appEntity);
                        },
                        tooltip: "Open in Store",
                        icon: const Icon(
                          Icons.open_in_new,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: hover ? 1.0 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: IconButton(
                        onPressed: () {
                          widget.controller.deleteApp(widget.appEntity);
                        },
                        tooltip: "Delete this app",
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const Gap(25),
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Image.network(
                          widget.appEntity.icon,
                          width: 64,
                        ),
                      ),
                      const Gap(11),
                      Text(
                        widget.appEntity.name,
                        style: AppTheme.fontSize(15).useSen(),
                      ),
                      const Gap(5),
                      FittedBox(
                        child: Container(
                          height: 25,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.categoryBackground,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.appEntity.category.name.capitalize!,
                            style: AppTheme.fontSize(14)
                                .useSen()
                                .withColor(AppTheme.categoryForeground),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Wrap(
                        spacing: 10,
                        children: [
                          ...widget.appEntity.supportedPlatforms.map(
                            (e) => Image.asset(
                              getPlatformIcon(e.type),
                              filterQuality: FilterQuality.high,
                              width: 24,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
