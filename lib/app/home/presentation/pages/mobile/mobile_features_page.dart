import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/bento_container.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class MobileFeaturesPage extends StatelessWidget {
  const MobileFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(60),
              Text(
                "Dive into Features",
                style: HomePageTheme.fontSize(18).makeBold(),
              ),
              Text(
                "Why not Fusion?",
                style: HomePageTheme.fontSize(16).withColor(Colors.grey),
              ),
              const Gap(20),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your users can directly reach out",
                      style: HomePageTheme.fontSize(14),
                    ),
                    Text(
                      "to you through the platform\n",
                      style: HomePageTheme.fontSize(14),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No registrations fees,",
                      style: HomePageTheme.fontSize(14).withColor(Colors.white),
                    ),
                    Text(
                      "Fusion is all free to use.",
                      style: HomePageTheme.fontSize(14),
                    ),
                    Image.asset(
                      AppIcons.noFees,
                      width: 200,
                    ),
                  ],
                ),
              ),
              BentoContainer(
                width: 300,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No commissions.",
                      style: HomePageTheme.fontSize(14).withColor(Colors.white),
                    ),
                    Text(
                      "Its your hard work, its your money.",
                      style: HomePageTheme.fontSize(14),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Host Multiple Versions",
                      style: HomePageTheme.fontSize(14),
                    ),
                    Text(
                      "of your apps simultaneously.",
                      style: HomePageTheme.fontSize(14),
                    ),
                    Image.asset(
                      AppIcons.versions,
                      width: 200,
                    ),
                  ],
                ),
              ),
              BentoContainer(
                width: 500,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Publishing is super fast in Fusion",
                      style: HomePageTheme.fontSize(14).withColor(Colors.white),
                    ),
                    Text(
                      "get your app live in an instant.",
                      style: HomePageTheme.fontSize(14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppIcons.editAppSpecs,
                              width: 120,
                            ),
                            Text(
                              "Add your app.",
                              style: HomePageTheme.fontSize(14),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: HomePageTheme.foreground,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppIcons.live,
                              width: 120,
                            ),
                            Text(
                              "Go Live! instantly.",
                              style: HomePageTheme.fontSize(14),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reach out to",
                      style: HomePageTheme.fontSize(14).withColor(Colors.white),
                    ),
                    Text(
                      "any linux distro in existence.",
                      style: HomePageTheme.fontSize(14),
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
