import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/bento_container.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class TabletFeaturesPage extends StatelessWidget {
  const TabletFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(100),
              Text(
                "Dive into Features",
                style: HomePageTheme.fontSize(42).makeBold(),
              ),
              Text(
                "Why not Fusion?",
                style: HomePageTheme.fontSize(20).withColor(Colors.grey),
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BentoContainer(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        const Gap(20),
                        Text(
                          "Your users can directly reach out",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Text(
                          "to you through the platform\n",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Image.asset(
                          AppIcons.messages,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  BentoContainer(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        const Gap(20),
                        Text(
                          "No registrations fees,",
                          style: HomePageTheme.fontSize(16)
                              .withColor(Colors.white),
                        ),
                        Text(
                          "Fusion is all free to use.",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Image.asset(
                          AppIcons.noFees,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BentoContainer(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        const Gap(20),
                        Text(
                          "No commissions.",
                          style: HomePageTheme.fontSize(16)
                              .withColor(Colors.white),
                        ),
                        Text(
                          "Its your hard work, its your money.",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Image.asset(
                          AppIcons.noCommissions,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  BentoContainer(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        const Gap(20),
                        Text(
                          "Host Multiple Versions",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Text(
                          "of your apps simultaneously.",
                          style: HomePageTheme.fontSize(16),
                        ),
                        Image.asset(
                          AppIcons.versions,
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BentoContainer(
                width: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Publishing is super fast in Fusion",
                      style: HomePageTheme.fontSize(20).withColor(Colors.white),
                    ),
                    Text(
                      "get your app live in an instant.",
                      style: HomePageTheme.fontSize(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppIcons.editAppSpecs,
                            ),
                            Text(
                              "Add your app.",
                              style: HomePageTheme.fontSize(16),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 48,
                          color: HomePageTheme.foreground,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppIcons.live,
                            ),
                            Text(
                              "Go Live! instantly.",
                              style: HomePageTheme.fontSize(16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    const Gap(20),
                    Text(
                      "Reach out to",
                      style: HomePageTheme.fontSize(16).withColor(Colors.white),
                    ),
                    Text(
                      "any linux distro in existence.",
                      style: HomePageTheme.fontSize(16),
                    ),
                    Image.asset(
                      AppIcons.allLinux,
                      width: 200,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.open_in_new,
                    color: HomePageTheme.foreground,
                  ),
                  const Gap(8),
                  Text(
                    "Read our docs for a full featured list",
                    style: HomePageTheme.fontSize(16).makeMedium(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
