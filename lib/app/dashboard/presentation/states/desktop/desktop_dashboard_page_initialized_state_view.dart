import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dialogs/edit_profile_dialog.dart';
import 'package:fusion_app_store/app/dashboard/presentation/panels/liked_apps_panel.dart';
import 'package:fusion_app_store/app/dashboard/presentation/panels/overall_statistics_panel.dart';
import 'package:fusion_app_store/app/dashboard/presentation/panels/owned_apps_panel.dart';
import 'package:fusion_app_store/app/dashboard/presentation/panels/reviews_panel.dart';
import 'package:fusion_app_store/app/dashboard/presentation/widgets/dashboard_button.dart';
import 'package:fusion_app_store/app/dashboard/presentation/widgets/dashboard_navigation_button.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';

enum ViewType {
  statistics,
  ownedApps,
  likedApps,
  reviews,
}

class DesktopDashboardPageInitializedStateView extends StatefulWidget {
  const DesktopDashboardPageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  @override
  State<DesktopDashboardPageInitializedStateView> createState() =>
      _DesktopDashboardPageInitializedStateViewState();
}

class _DesktopDashboardPageInitializedStateViewState
    extends State<DesktopDashboardPageInitializedStateView> {
  late PageController pageController;

  late ViewType currentViewType;

  @override
  void initState() {
    super.initState();
    currentViewType = widget.state.initialViewType ?? ViewType.statistics;
    pageController = PageController(
        keepPage: true, initialPage: ViewType.values.indexOf(currentViewType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dashboardBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 16,
                )
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 18.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 240,
                              height: 240,
                              child: Image.network(
                                widget.state.userEntity.avatarUrl,
                              ),
                            ),
                            Text(
                              "${greet()}, ${widget.state.userEntity.username}",
                              style: AppTheme.fontSize(20).makeMedium(),
                            ),
                            const Gap(10),
                            TextButton(
                              onPressed: () {
                                EditProfileDialog.open(
                                  context,
                                  widget.controller,
                                  widget.state,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    color: Colors.grey,
                                  ),
                                  const Gap(5),
                                  Text(
                                    "Edit Profile",
                                    style: AppTheme.fontSize(14)
                                        .withColor(Colors.grey)
                                        .makeMedium(),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(25),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  runSpacing: 25,
                                  children: [
                                    DashboardNavigationButton(
                                      onPressed: () {
                                        setState(() {
                                          currentViewType = ViewType.statistics;
                                          pageController.jumpToPage(0);
                                        });
                                      },
                                      active: currentViewType ==
                                          ViewType.statistics,
                                      icon: Icons.style_rounded,
                                      activeIconColors: const [
                                        Colors.pink,
                                        Colors.indigoAccent,
                                      ],
                                      text: "Overall Statistics",
                                    ),
                                    DashboardNavigationButton(
                                      onPressed: () {
                                        setState(() {
                                          currentViewType = ViewType.ownedApps;
                                          pageController.jumpToPage(1);
                                        });
                                      },
                                      active:
                                          currentViewType == ViewType.ownedApps,
                                      icon: Icons.app_registration_rounded,
                                      activeIconColors: const [
                                        Colors.blue,
                                        Colors.cyan
                                      ],
                                      text: "Owned Apps",
                                    ),
                                    DashboardNavigationButton(
                                      onPressed: () {
                                        setState(() {
                                          currentViewType = ViewType.likedApps;
                                          pageController.jumpToPage(2);
                                        });
                                      },
                                      active:
                                          currentViewType == ViewType.likedApps,
                                      icon: Icons.favorite,
                                      activeIconColors: const [
                                        Colors.red,
                                        Colors.redAccent,
                                      ],
                                      text: "Liked Apps",
                                    ),
                                    DashboardNavigationButton(
                                      onPressed: () {
                                        setState(() {
                                          currentViewType = ViewType.reviews;
                                          pageController.jumpToPage(3);
                                        });
                                      },
                                      active:
                                          currentViewType == ViewType.reviews,
                                      icon: Icons.rate_review,
                                      activeIconColors: [
                                        Colors.redAccent,
                                        Colors.yellow.shade900,
                                      ],
                                      text: "Apps you Reviewed",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(25),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CoreAppButton(
                                  text: "Go to Store",
                                  icon: Icon(
                                    Icons.storefront,
                                    color: AppTheme.foreground,
                                  ),
                                  onPressed: () {
                                    widget.controller.gotoStore();
                                  },
                                ),
                                const Gap(10),
                                CoreAppButton(
                                  text: "Log Out",
                                  icon: Icon(
                                    Icons.logout,
                                    color: AppTheme.foreground,
                                  ),
                                  onPressed: () {
                                    widget.controller.logOut();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: VerticalDivider(
                          thickness: 2,
                          color: AppTheme.dividerColor,
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          children: [
                            OverallStatisticsPanel(
                              controller: widget.controller,
                              state: widget.state,
                            ),
                            OwnedAppsPanel(
                              controller: widget.controller,
                              state: widget.state,
                            ),
                            LikedAppsPanel(
                              controller: widget.controller,
                              state: widget.state,
                            ),
                            ReviewsPanel(
                              controller: widget.controller,
                              state: widget.state,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: AppTheme.dashboardCardColor,
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     margin: const EdgeInsets.all(16.0),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 16.0, vertical: 8.0),
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           // DashboardButton(
                //           //   iconUrl:
                //           //       "https://img.icons8.com/cotton/32/paper-plane--v4.png",
                //           //   text: "Messages",
                //           //   onPressed: () {},
                //           // ),
                //           // const Gap(10),
                //           DashboardButton(
                //             iconUrl:
                //                 "https://img.icons8.com/cotton/32/jingle-bell--v2.png",
                //             text: "Notifications",
                //             onPressed: () {},
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
