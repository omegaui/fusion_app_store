import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_controller.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../core/global/ui_utils.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key, required this.controller});

  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppIcons.appIcon,
                          width: 125,
                        ),
                        Text(
                          "Fusion App Store",
                          style: HomePageTheme.fontSize(32),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // AppButton(
                        //   text: "Sign Up",
                        //   onPressed: () {
                        //     Get.find<RouteService>().navigateTo(
                        //       page: RouteService.errorPage,
                        //       arguments: [
                        //         "This is a test",
                        //         "Some error has occurred",
                        //       ],
                        //     );
                        //   },
                        // ),
                        const Gap(10),
                        AppButton(
                          text: "Login",
                          onPressed: () {
                            controller.gotoAuthRoute();
                          },
                        ),
                        const Gap(10),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "With Fusion you can publish",
                style: HomePageTheme.fontSize(56)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              Text(
                "your apps to all platforms at one go.",
                style: HomePageTheme.fontSize(56).makeBold(),
              ),
              const Gap(25),
              Text(
                "Fusion is not only about publishing",
                style: HomePageTheme.fontSize(20).withColor(Colors.grey),
              ),
              Text(
                "Its a platform to build a powerful community of app publishers.",
                style: HomePageTheme.fontSize(20).withColor(Colors.grey),
              ),
              const Gap(60),
              buildImageList([
                AppIcons.windows,
                AppIcons.ubuntu,
                AppIcons.mac,
                AppIcons.debian,
                AppIcons.fedora
              ], 29),
              const Gap(20),
              buildImageList([
                AppIcons.arch,
                AppIcons.tizen,
                AppIcons.ios,
                AppIcons.android,
              ], 43),
              const Gap(60),
              AppButton(
                text: "Visit Fusion App Store",
                fontSize: 16,
                icon: const Icon(
                  Icons.storefront,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              const Gap(60),
              Text(
                "It's more than just an app store",
                style: HomePageTheme.fontSize(48)
                    .makeBold()
                    .withColor(Colors.grey),
              ),
              Text(
                "It's a step towards freedom",
                style: HomePageTheme.fontSize(32)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              const Gap(30),
            ],
          ),
        ),
      ],
    );
  }
}
