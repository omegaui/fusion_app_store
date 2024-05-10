import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: "Store",
                  onPressed: () {},
                ),
                AppButton(
                  text: "Login",
                  onPressed: () {
                    controller.gotoAuthRoute();
                  },
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          AppIcons.appIcon,
          width: 125,
        ),
        Text(
          "With Fusion you can publish",
          style: HomePageTheme.fontSize(16).makeBold().withColor(Colors.white),
        ),
        Text(
          "your apps to all platforms at one go.",
          style: HomePageTheme.fontSize(16).makeBold(),
        ),
        const Gap(25),
        Text(
          "Fusion is not only about publishing",
          style: HomePageTheme.fontSize(14).withColor(Colors.grey),
        ),
        Text(
          "Its a platform to build a powerful community of app publishers.",
          textAlign: TextAlign.center,
          style: HomePageTheme.fontSize(14).withColor(Colors.grey),
        ),
        const Gap(30),
        buildImageList([
          AppIcons.windows,
          AppIcons.ubuntu,
          AppIcons.mac,
          AppIcons.debian,
          AppIcons.fedora
        ], 20, iconSize: 48),
        const Gap(20),
        buildImageList([
          AppIcons.arch,
          AppIcons.tizen,
          AppIcons.ios,
          AppIcons.android,
        ], 26, iconSize: 48),
        const Gap(60),
        AppButton(
          text: "Visit Fusion App Store",
          fontSize: 14,
          icon: const Icon(
            Icons.storefront,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
        const Gap(60),
        Text(
          "It's more than just an app store",
          style: HomePageTheme.fontSize(16).makeBold().withColor(Colors.grey),
        ),
        Text(
          "It's a step towards freedom",
          style: HomePageTheme.fontSize(14).makeBold().withColor(Colors.white),
        ),
      ],
    );
  }
}
