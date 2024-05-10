import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/auth/presentation/dialogs/privacy_policy_dialog.dart';
import 'package:fusion_app_store/app/auth/presentation/dialogs/terms_of_service_dialog.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DesktopAboutPage extends StatelessWidget {
  const DesktopAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              const Gap(120),
              Text(
                "Fusion App Store",
                style: HomePageTheme.fontSize(56)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Breaking",
                    style: HomePageTheme.fontSize(20)
                        .makeBold()
                        .withColor(Colors.grey),
                  ),
                  Text(
                    " the platform",
                    style: HomePageTheme.fontSize(20).withColor(Colors.grey),
                  ),
                  Text(
                    " barrier.",
                    style: HomePageTheme.fontSize(20)
                        .makeBold()
                        .withColor(Colors.grey),
                  ),
                ],
              ),
              Image.asset(
                AppIcons.appIcon,
                width: 250,
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(colors: [
                  Colors.white,
                  Colors.grey,
                ]).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  "Uniting Platforms. Uniting People.\nUniting Apps.",
                  textAlign: TextAlign.center,
                  style: HomePageTheme.fontSize(32)
                      .withColor(Colors.white)
                      .makeBold(),
                ),
              ),
              const Gap(30),
              Text(
                "It's an effort to break off limits in software publishing",
                textAlign: TextAlign.center,
                style: HomePageTheme.fontSize(48)
                    .makeBold()
                    .withColor(Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Learn more about",
                    textAlign: TextAlign.center,
                    style: HomePageTheme.fontSize(48)
                        .makeBold()
                        .withColor(Colors.white),
                  ),
                  Text(
                    " The Fusion Project",
                    textAlign: TextAlign.center,
                    style: HomePageTheme.fontSize(48).makeBold(),
                  ),
                  const Gap(15),
                  const Icon(
                    Icons.open_in_new,
                    size: 48,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          text: "Contact Us",
                          onPressed: () {},
                        ),
                        const Gap(10),
                        AppButton(
                          text: "Visit Store",
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppButton(
                          text: "Privacy Policy",
                          onPressed: PrivacyPolicyDialog.view,
                        ),
                        const Gap(10),
                        const AppButton(
                          text: "Terms & Conditions",
                          onPressed: TermsOfServiceDialog.view,
                        ),
                        const Gap(10),
                        AppButton(
                          text: "The Fusion Project",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(30),
              SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Copyright © 2024 The Fusion Project",
                    style: HomePageTheme.fontSize(24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
