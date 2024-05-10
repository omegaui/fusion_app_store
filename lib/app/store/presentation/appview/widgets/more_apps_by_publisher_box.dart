import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/store/widgets/store_app_card.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class MoreAppsByPublisherBox extends StatelessWidget {
  const MoreAppsByPublisherBox({
    super.key,
    required this.publisher,
    required this.moreApps,
    required this.controller,
  });

  final UserEntity publisher;
  final List<AppEntity> moreApps;
  final AppViewPageController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 420,
        margin: const EdgeInsets.symmetric(horizontal: 26),
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 27),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [getBoxesShadow()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  "More Apps by ${publisher.username}",
                  style: AppTheme.fontSize(20).makeBold().useSen(),
                ),
              ],
            ),
            const Gap(19),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  children: moreApps
                      .map(
                        (e) => StoreAppCard(
                          app: e,
                          onPressed: () {
                            controller.viewApp(e);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
