import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_controller.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

import '../../../../core/global/core_app_button.dart';

class AuthPageInitializedStateView extends StatefulWidget {
  const AuthPageInitializedStateView({
    super.key,
    required this.controller,
    required this.deviceType,
  });

  final AuthPageController controller;
  final DeviceType deviceType;

  @override
  State<AuthPageInitializedStateView> createState() =>
      _AuthPageInitializedStateViewState();
}

class _AuthPageInitializedStateViewState
    extends State<AuthPageInitializedStateView>
    with SingleTickerProviderStateMixin<AuthPageInitializedStateView> {
  int _getParticleCount() {
    switch (widget.deviceType) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.desktop:
        return 60;
      case DeviceType.tablet:
        return 40;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  particleCount: _getParticleCount(),
                ),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
              ),
            ),
          ),
          Align(
            child: Column(
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    AppIcons.appIcon,
                    width: 250,
                  ),
                ),
                Text(
                  "Hey, there!",
                  style: AppTheme.fontSize(42).makeMedium(),
                ),
                Text(
                  "Welcome to Fusion App Store",
                  style: AppTheme.fontSize(
                      widget.deviceType == DeviceType.mobile ? 20 : 32),
                ),
                const Gap(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: Image.asset(
                        AppIcons.google,
                      ),
                    ),
                    const Gap(20),
                    CoreAppButton(
                      onPressed: () {
                        widget.controller.loginWithGoogle();
                      },
                      text: "Sign in Google",
                      fontSize: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
