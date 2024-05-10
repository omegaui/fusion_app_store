import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/pages/mobile/mobile_about_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/mobile/mobile_community_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/mobile/mobile_features_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/mobile/mobile_home_page.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/mobile_home_nav_bar.dart';
import 'package:fusion_app_store/config/app_artworks.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class HomePageInitializedMobileStateView extends StatefulWidget {
  const HomePageInitializedMobileStateView({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  State<HomePageInitializedMobileStateView> createState() =>
      _HomePageInitializedMobileStateViewState();
}

class _HomePageInitializedMobileStateViewState
    extends State<HomePageInitializedMobileStateView> {
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
                AppArtWorks.homeBackgroundPortrait,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  MobileHomePage(controller: widget.controller),
                  const MobileFeaturesPage(),
                  const MobileCommunityPage(),
                  const MobileAboutPage(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: MobileHomeNavBar(
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
