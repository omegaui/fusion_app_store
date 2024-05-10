import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/bento_container.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class MobileCommunityPage extends StatelessWidget {
  const MobileCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              const Gap(80),
              Text(
                "App Store Reimagined",
                style: HomePageTheme.fontSize(18)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              Text(
                "Let's build it how it should have been since the beginning",
                textAlign: TextAlign.center,
                style: HomePageTheme.fontSize(16).withColor(Colors.grey),
              ),
              const Gap(20),
              Image.asset(
                AppIcons.community,
                width: 200,
              ),
              Text(
                "Let's build a global community, together.",
                style: HomePageTheme.fontSize(16).makeBold(),
              ),
              const Gap(30),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    const Gap(15),
                    Image.asset(
                      AppIcons.profile,
                      width: 200,
                    ),
                    const Gap(15),
                    Text(
                      "Build your unique publisher profile",
                      style: HomePageTheme.fontSize(16),
                    ),
                    Text(
                      "Not just upload apps, do more than that.",
                      style: HomePageTheme.fontSize(14),
                    ),
                  ],
                ),
              ),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    const Gap(15),
                    Image.asset(
                      AppIcons.friends,
                      width: 200,
                    ),
                    const Gap(15),
                    Text(
                      "Connect with other publishers",
                      style: HomePageTheme.fontSize(16),
                    ),
                    Text(
                      "It's not only about apps, it's about people.",
                      style: HomePageTheme.fontSize(14),
                    ),
                  ],
                ),
              ),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    const Gap(15),
                    Image.asset(
                      AppIcons.grow,
                      width: 200,
                    ),
                    const Gap(15),
                    Text(
                      "Let's grow better, together.",
                      style: HomePageTheme.fontSize(16),
                    ),
                    Text(
                      "Seek out help from community members.",
                      style: HomePageTheme.fontSize(14),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "Contribute in creating a friendly ecosystem",
                style: HomePageTheme.fontSize(18).makeBold(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
