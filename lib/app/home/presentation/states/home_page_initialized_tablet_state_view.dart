import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/pages/tablet/tablet_about_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/tablet/tablet_community_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/tablet/tablet_features_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/tablet/tablet_home_page.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/tablet_home_nav_bar.dart';
import 'package:fusion_app_store/config/app_artworks.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class HomePageInitializedTabletStateView extends StatefulWidget {
  const HomePageInitializedTabletStateView({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  State<HomePageInitializedTabletStateView> createState() =>
      _HomePageInitializedTabletStateViewState();
}

class _HomePageInitializedTabletStateViewState
    extends State<HomePageInitializedTabletStateView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePageTheme.background,
      body: Stack(
        children: [
          Align(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Image.asset(
                AppArtWorks.homeBackground,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  TabletHomePage(controller: widget.controller),
                  const TabletFeaturesPage(),
                  const TabletCommunityPage(),
                  const TabletAboutPage(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TabletHomeNavBar(
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
