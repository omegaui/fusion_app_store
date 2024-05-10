import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/pages/desktop/desktop_community_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/desktop/desktop_features_page.dart';
import 'package:fusion_app_store/app/home/presentation/pages/desktop/desktop_home_page.dart';
import 'package:fusion_app_store/config/app_artworks.dart';
import 'package:fusion_app_store/config/app_theme.dart';

import '../pages/desktop/desktop_about_page.dart';
import '../widgets/desktop_home_nav_bar.dart';

class HomePageInitializedDesktopStateView extends StatefulWidget {
  const HomePageInitializedDesktopStateView(
      {super.key, required this.controller});

  final HomePageController controller;

  @override
  State<HomePageInitializedDesktopStateView> createState() =>
      _HomePageInitializedDesktopStateViewState();
}

class _HomePageInitializedDesktopStateViewState
    extends State<HomePageInitializedDesktopStateView>
    with SingleTickerProviderStateMixin<HomePageInitializedDesktopStateView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePageTheme.background,
      body: Stack(
        children: [
          Align(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Image.asset(
                AppArtWorks.homeBackground,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(
                  options: const ParticleOptions(
                baseColor: Colors.white,
                maxOpacity: 1.0,
                minOpacity: 0.4,
                spawnMinRadius: 1.0,
                spawnMaxRadius: 1.2,
                spawnMinSpeed: 2.0,
                spawnMaxSpeed: 15.0,
                particleCount: 50,
              )),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
              ),
            ),
          ),
          Align(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  DesktopHomePage(controller: widget.controller),
                  const DesktopFeaturesPage(),
                  const DesktopCommunityPage(),
                  const DesktopAboutPage(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: DesktopHomeNavBar(
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
