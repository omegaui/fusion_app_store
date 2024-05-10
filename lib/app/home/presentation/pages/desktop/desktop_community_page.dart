import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/bento_container.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DesktopCommunityPage extends StatelessWidget {
  const DesktopCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              const Gap(100),
              Text(
                "App Store Reimagined",
                style: HomePageTheme.fontSize(56)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              Text(
                "Let's build it how it should have been since the beginning",
                style: HomePageTheme.fontSize(20).withColor(Colors.grey),
              ),
              const Gap(20),
              Image.asset(
                AppIcons.community,
              ),
              Text(
                "Let's build a global community, together.",
                style: HomePageTheme.fontSize(26).makeBold(),
              ),
              const Gap(30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BentoContainer(
                      width: 400,
                      height: 350,
                      child: Column(
                        children: [
                          const Gap(15),
                          Image.asset(
                            AppIcons.profile,
                          ),
                          const Gap(15),
                          Text(
                            "Build your unique publisher profile",
                            style: HomePageTheme.fontSize(20),
                          ),
                          Text(
                            "Not just upload apps, do more than that.",
                            style: HomePageTheme.fontSize(16),
                          ),
                        ],
                      ),
                    ),
                    BentoContainer(
                      width: 400,
                      height: 350,
                      child: Column(
                        children: [
                          const Gap(15),
                          Image.asset(
                            AppIcons.friends,
                          ),
                          const Gap(15),
                          Text(
                            "Connect with other publishers",
                            style: HomePageTheme.fontSize(20),
                          ),
                          Text(
                            "It's not only about apps, it's about the people.",
                            style: HomePageTheme.fontSize(16),
                          ),
                        ],
                      ),
                    ),
                    BentoContainer(
                      width: 400,
                      height: 350,
                      child: Column(
                        children: [
                          const Gap(15),
                          Image.asset(
                            AppIcons.grow,
                          ),
                          const Gap(15),
                          Text(
                            "Let's grow better, together.",
                            style: HomePageTheme.fontSize(20),
                          ),
                          Text(
                            "Seek out help from community members.",
                            style: HomePageTheme.fontSize(16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "Contribute in creating a friendly ecosystem",
                style: HomePageTheme.fontSize(32).makeBold(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
