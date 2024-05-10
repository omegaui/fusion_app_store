import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/esrb_rating.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_controller.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_states_and_events.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/additional_information_box.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/download_button.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/like_button.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/more_apps_by_publisher_box.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/permissions_box.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/reactions_button_group.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/reviews_box.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/screenshots_box.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/system_requirements_box.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/extras.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/cache_storage/cache.dart';
import '../widgets/description_box.dart';

class AppViewPageInitializedStateView extends StatefulWidget {
  const AppViewPageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
    required this.deviceType,
  });

  final AppViewPageController controller;
  final AppViewPageInitializedState state;
  final DeviceType deviceType;

  @override
  State<AppViewPageInitializedStateView> createState() =>
      _AppViewPageInitializedStateViewState();
}

class _AppViewPageInitializedStateViewState
    extends State<AppViewPageInitializedStateView> {
  // keys
  final reviewBoxKey = GlobalKey<ReviewsBoxState>();

  // scroll controller
  final scrollController = ScrollController();

  // top bar config
  bool showTopBar = true;
  bool showFooter = false;

  // app card color
  Color primaryColor = Colors.blue.shade100;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final scrollingUp = scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
      if (showTopBar != scrollingUp) {
        showTopBar = scrollingUp;
        rebuildPostFrame();
      }

      final atBottom =
          scrollController.offset != 0 && scrollController.position.atEdge;
      if (showFooter != atBottom) {
        showFooter = atBottom;
        rebuildPostFrame();
      }
    });

    final colorID = '${widget.state.appEntity.appID}-Card-Color';
    final color = AppCache.get(
      key: colorID,
      fallback: null,
    );
    if (color != null) {
      primaryColor = color;
    } else {
      Future(() async {
        await cacheDominantColor(
          colorID,
          widget.state.appEntity.icon,
        );
        setState(() {
          final color = AppCache.get(
            key: colorID,
            fallback: null,
          );
          if (color != null) {
            primaryColor = color;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = isLikedApp(widget.state.publisher, widget.state.appEntity);
    Reaction? initialReaction = widget.state.appReviewEntity.reviews
        .firstWhereOrNull((e) => e.username == widget.state.publisher.username)
        ?.reaction;
    return Scaffold(
      backgroundColor: AppTheme.appViewBackground,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 67.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 8),
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(100),
                    Row(
                      children: [
                        SizedBox(
                          width: 190,
                          height: 240,
                          child: Stack(
                            children: [
                              Align(
                                child: Container(
                                  width: 190,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    color: AppTheme.appViewIconBoxColor,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.network(
                                      widget.state.appEntity.icon,
                                      width: 96,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: LikeButton(
                                  liked: isLiked,
                                  onPressed: () {
                                    widget.controller.likeApp(
                                        !isLiked, widget.state.appEntity);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(40),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.state.appEntity.name,
                                  style:
                                      AppTheme.fontSize(26).makeBold().useSen(),
                                ),
                                if (widget.state.appEntity.verified) ...[
                                  const Gap(10),
                                  const Icon(
                                    Icons.verified_rounded,
                                    color: Colors.blue,
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(
                              width: 436,
                              child: Text(
                                widget.state.appEntity.shortDescription,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppTheme.fontSize(14).makeMedium().useSen(),
                              ),
                            ),
                            const Gap(10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                parseAppCategory(
                                    widget.state.appEntity.category),
                                style:
                                    AppTheme.fontSize(14).makeBold().useSen(),
                              ),
                            ),
                            const Gap(10),
                            Wrap(
                              spacing: 15,
                              children:
                                  widget.state.appEntity.supportedPlatforms
                                      .map(
                                        (e) => Image.asset(
                                          getPlatformIcon(e.type),
                                          width: 32,
                                        ),
                                      )
                                      .toList(),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  DownloadButton(
                                    appEntity: widget.state.appEntity,
                                    controller: widget.controller,
                                  ),
                                  const Gap(10),
                                  ReactionsButtonGroup(
                                    initialReaction: initialReaction,
                                    appReviewEntity:
                                        widget.state.appReviewEntity,
                                    onPressed: (e) {
                                      selectedReaction = e;
                                      reviewDescriptionFocusNode.requestFocus();
                                      reviewBoxKey.currentState!.rebuild();
                                    },
                                  ),
                                  const Gap(10),
                                  Row(
                                    children: [
                                      Image.asset(
                                        getEsrbRatingIcon(
                                          widget.state.appEntity.esrbRating,
                                        ),
                                        width: 48,
                                      ),
                                      const Gap(10),
                                      Text(
                                        parseEsrbRating(
                                            widget.state.appEntity.esrbRating),
                                        style: AppTheme.fontSize(14)
                                            .makeMedium()
                                            .useSen(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(26),
                    Row(
                      children: [
                        ScreenshotsBox(
                            screenshots: widget.state.appEntity.imageUrls),
                        AdditionalInformationBox(
                          publisher: widget.state.publisher,
                          appEntity: widget.state.appEntity,
                        ),
                      ],
                    ),
                    const Gap(26),
                    Row(
                      children: [
                        DescriptionBox(
                            description: widget.state.appEntity.description),
                        if (widget.state.moreAppsByPublisher.isNotEmpty) ...[
                          MoreAppsByPublisherBox(
                            publisher: widget.state.publisher,
                            moreApps: widget.state.moreAppsByPublisher,
                            controller: widget.controller,
                          ),
                        ],
                      ],
                    ),
                    const Gap(26),
                    ReviewsBox(
                      key: reviewBoxKey,
                      publisher: widget.state.publisher,
                      appEntity: widget.state.appEntity,
                      appReviewEntity: widget.state.appReviewEntity,
                      usersWhoReviewed: widget.state.usersWhoReviewed,
                      controller: widget.controller,
                    ),
                    const Gap(26),
                    PermissionsBox(
                        permissions: widget.state.appEntity.permissions),
                    const Gap(26),
                    SystemRequirementsBox(
                      minimum: widget.state.appEntity.systemRequirements[0],
                      maximum: widget.state.appEntity.systemRequirements[1],
                    ),
                    const Gap(100),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _buildTopBar(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFooter(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      offset: showTopBar ? const Offset(0, 0) : const Offset(0, -1),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 53,
        decoration: BoxDecoration(
          color: AppTheme.appViewTopBarColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
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
            if (!widget.state.appEntity.verified) ...[
              const Gap(10),
              TextButton(
                onPressed: () {
                  widget.controller.verifyApp(widget.state.appEntity);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade100,
                ),
                child: Text(
                  "Mark as Verified",
                  style: AppTheme.fontSize(14).makeMedium().useSen(),
                ),
              ),
            ],
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.controller.gotoDashboard();
                    },
                    tooltip: "Open Dashboard",
                    icon: Image.network(
                      widget.state.publisher.avatarUrl,
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
                  const Gap(10),
                  IconButton(
                    onPressed: () {},
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
      ),
    );
  }

  Widget _buildFooter() {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      offset: showFooter ? const Offset(0, 0) : const Offset(0, 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        width: MediaQuery.sizeOf(context).width,
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 47.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildLink("Report App", ""),
                  _buildLink("Privacy Policy", ""),
                  _buildLink("Terms & Conditions", ""),
                  _buildLink("Publishing Policies", ""),
                  _buildLink("App Guidelines", ""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLink(String title, String url) {
    return TextButton(
      onPressed: () {
        launchUrlString(url);
      },
      child: Text(
        title,
        style: AppTheme.fontSize(14).makeBold(),
      ),
    );
  }

  void rebuildPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}

BoxShadow getBoxesShadow() {
  return BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    blurRadius: 8,
  );
}
