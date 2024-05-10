import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_controller.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_states_and_events.dart';
import 'package:fusion_app_store/app/onboarding/presentation/widgets/step_box.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/config/app_avatars.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_illustrations.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/user_type.dart';
import 'package:fusion_app_store/core/cloud_storage/global.dart';
import 'package:fusion_app_store/core/global/core_app_button.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OnBoardingPageInitializedStateView extends StatefulWidget {
  const OnBoardingPageInitializedStateView({
    super.key,
    required this.controller,
    required this.state,
  });

  final OnBoardingPageController controller;
  final OnBoardingPageInitializedState state;

  @override
  State<OnBoardingPageInitializedStateView> createState() =>
      _OnBoardingPageInitializedStateViewState();
}

class _OnBoardingPageInitializedStateViewState
    extends State<OnBoardingPageInitializedStateView> {
  // Temporary Instance
  UserEntity entity = UserEntity.empty;

  // Page Controls
  final pageController = PageController(keepPage: true);
  List<int> completedSteps = [];
  int currentStep = 1;
  int width = 600;
  int height = 500;

  // credentials step
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    entity = UserEntity.clone(
      entity,
      userLoginEmail: GlobalFirebaseUtils.getCurrentUserLoginEmail(),
      avatarUrl: AppAvatars.avatarUrls
          .elementAt(Random().nextInt(AppAvatars.avatarUrls.length)),
      bio: getRandomBio(),
    );
    super.initState();
  }

  Widget _getIllustration() {
    if (currentStep == 1) {
      return Image.asset(
        AppIllustrations.credentials,
        key: const ValueKey(AppIllustrations.credentials),
        width: 500,
      );
    } else if (currentStep == 2) {
      return Image.asset(
        AppIllustrations.userType,
        key: const ValueKey(AppIllustrations.userType),
        width: 500,
      );
    } else if (currentStep == 3) {
      return Image.asset(
        AppIllustrations.avatar,
        key: const ValueKey(AppIllustrations.avatar),
        width: 500,
      );
    }
    return Image.asset(
      AppIllustrations.rocket,
      key: const ValueKey(AppIllustrations.rocket),
      width: 500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              AppIllustrations.onBoardingShape,
              width: 649.77,
            ),
          ),
          if (widget.state.deviceType == DeviceType.desktop) ...[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 400.0),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: const Offset(0, 0))
                            .animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _getIllustration(),
                ),
              ),
            ),
          ],
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      widget.state.deviceType == DeviceType.desktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.controller.logOut();
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Tooltip(
                              message: "Log Out",
                              child: Image.asset(
                                AppIcons.backArrow,
                                width: widget.state.deviceType !=
                                        DeviceType.desktop
                                    ? 32
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Gap(widget.state.deviceType != DeviceType.desktop
                            ? 10
                            : 28),
                        Text(
                          "Complete Your Account Setup",
                          style: AppTheme.fontSize(
                              widget.state.deviceType == DeviceType.desktop
                                  ? 42
                                  : 20),
                        ),
                      ],
                    ),
                    const Gap(30),
                    Container(
                      width: 600,
                      height: 120,
                      margin: EdgeInsets.only(
                          left: widget.state.deviceType == DeviceType.desktop
                              ? 80
                              : 0),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.curvedTopBarDropShadowColor
                                .withOpacity(0.1),
                            blurRadius: 16,
                            blurStyle: BlurStyle.solid,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Steps to complete",
                              style: AppTheme.fontSize(16).makeBold(),
                            ),
                          ),
                          Transform.scale(
                            scale: widget.state.deviceType == DeviceType.desktop
                                ? 1.0
                                : 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StepBox(
                                  step: "1",
                                  done: completedSteps.contains(1),
                                  onPressed: () {
                                    setState(() {
                                      width = 600;
                                      height = 500;
                                      currentStep = 1;
                                    });
                                    pageController.jumpToPage(0);
                                  },
                                ),
                                StepBox(
                                  step: "2",
                                  done: completedSteps.contains(2),
                                  onPressed: () {
                                    setState(() {
                                      width = 700;
                                      height = 500;
                                      currentStep = 2;
                                    });
                                    pageController.jumpToPage(1);
                                  },
                                ),
                                StepBox(
                                  step: "3",
                                  done: completedSteps.contains(3),
                                  showLine: widget.state.deviceType !=
                                      DeviceType.mobile,
                                  onPressed: () {
                                    setState(() {
                                      width = 600;
                                      height = 500;
                                      currentStep = 3;
                                    });
                                    pageController.jumpToPage(2);
                                  },
                                ),
                                if (widget.state.deviceType !=
                                    DeviceType.mobile) ...[
                                  StepBox(
                                    step: "⚡",
                                    done: completedSteps.contains(4),
                                    onPressed: () {
                                      setState(() {
                                        width = 600;
                                        height = 500;
                                        currentStep = 4;
                                      });
                                      pageController.jumpToPage(3);
                                    },
                                    showLine: false,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    FittedBox(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeIn,
                        width: width.toDouble(),
                        height: height.toDouble(),
                        margin: EdgeInsets.only(
                            left: widget.state.deviceType == DeviceType.desktop
                                ? 80
                                : 0),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.curvedTopBarDropShadowColor,
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: PageView(
                          controller: pageController,
                          children: [
                            setupLoginCredentials(),
                            setupUserType(),
                            setupAvatar(),
                            onBoardingCompleteView(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setupLoginCredentials() {
    bool showPassword = false;

    Widget getIcon() {
      if (widget.state.usernameAvailable == null) {
        return Icon(
          Icons.find_replace,
          color: AppTheme.foreground,
        );
      } else if (!widget.state.usernameAvailable!) {
        return const Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        );
      }
      return const Icon(
        Icons.done,
        color: Colors.green,
      );
    }

    String getTooltip() {
      if (widget.state.usernameAvailable == null) {
        return "Check if this name is available";
      } else if (!widget.state.usernameAvailable!) {
        return "Username already picked by someone";
      }
      return "This is username is available";
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Let's setup your login credentials",
            style: AppTheme.fontSize(22).makeMedium(),
          ),
          const Gap(20),
          StatefulBuilder(builder: (context, setModalState) {
            return SizedBox(
              width: 320,
              child: TextFormField(
                controller: usernameController,
                style: AppTheme.fontSize(16).makeMedium(),
                validator: (value) {
                  if (!isValidUsername(value!)) {
                    return "*Only lowercase alphabets and digits are allowed";
                  }
                  return null;
                },
                onChanged: (value) {
                  setModalState(() {});
                },
                decoration: InputDecorations.createUnderLined(
                  labelText: "Username",
                  hintText: "e.g: omegaui",
                ).copyWith(
                  suffix: !isValidUsername(usernameController.text)
                      ? const SizedBox(
                          height: 30,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: getTooltip(),
                              onPressed: () {
                                widget.controller.isUsernameAvailable(
                                  usernameController.text,
                                  widget.state.deviceType,
                                );
                              },
                              icon: getIcon(),
                            ),
                          ],
                        ),
                ),
              ),
            );
          }),
          const Gap(20),
          StatefulBuilder(
            builder: (context, setModalState) => SizedBox(
              width: 320,
              child: TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                style: AppTheme.fontSize(16).makeMedium(),
                validator: (value) {
                  if (!isValidPassword(value!)) {
                    return "*Only Digits, Symbols and Alphabets (one each)";
                  }
                  return null;
                },
                decoration: InputDecorations.createUnderLined(
                  labelText: "Password",
                  hintText: "Password",
                ).copyWith(
                  suffix: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setModalState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: AppTheme.foreground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(30),
          CoreAppButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.controller.isUsernameAvailable(
                  usernameController.text,
                  widget.state.deviceType,
                  onSuccess: () {
                    entity = UserEntity.clone(
                      entity,
                      username: usernameController.text,
                      password: encrypt(passwordController.text),
                    );
                    setState(() {
                      width = 700;
                      height = 500;
                      completedSteps.add(currentStep++);
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    });
                  },
                );
              }
            },
            text: "Use this as my login",
            fontSize: 16,
          ),
        ],
      ),
    );
  }

  Widget setupUserType() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Gap(20),
              Text(
                "What defines you the best?",
                style: AppTheme.fontSize(22).makeMedium(),
              ),
              Image.asset(
                AppIllustrations.getUserTypeIllustration(entity.userType),
                height: 400,
              ),
              Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...UserType.values.map(
                    (e) => SizedBox(
                      width: 120,
                      child: RadioMenuButton<UserType>(
                        value: e,
                        groupValue: entity.userType,
                        onChanged: (value) {
                          setState(() {
                            entity = UserEntity.clone(entity, userType: value);
                          });
                        },
                        child: Text(
                          e.name.capitalize!,
                          style: AppTheme.fontSize(14).makeMedium(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CoreAppButton(
              onPressed: () {
                setState(() {
                  width = 600;
                  height = 500;
                  completedSteps.add(currentStep++);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                });
              },
              text: "Next",
            ),
          ),
        ),
      ],
    );
  }

  Widget setupAvatar() {
    return Stack(
      children: [
        Align(
          child: Column(
            children: [
              const Gap(20),
              Text(
                "Pick your avatar",
                style: AppTheme.fontSize(22).makeMedium(),
              ),
              const Gap(20),
              Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.network(
                  entity.avatarUrl,
                ),
              ),
              const Gap(20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: AppAvatars.avatarUrls.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            entity = UserEntity.clone(entity, avatarUrl: e);
                          });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Image.network(
                            e,
                            width: 70,
                            height: 70,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Tooltip(
              message: "Use my google profile icon",
              child: CoreAppButton(
                onPressed: () {
                  setState(() {
                    entity = UserEntity.clone(
                      entity,
                      avatarUrl:
                          GlobalFirebaseUtils.getCurrentUserGoogleAvatar(),
                    );
                  });
                },
                text: "Google Profile",
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CoreAppButton(
              onPressed: () {
                setState(() {
                  width = 600;
                  height = 500;
                  completedSteps.add(currentStep++);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                });
              },
              text: "Next",
            ),
          ),
        ),
      ],
    );
  }

  Widget onBoardingCompleteView() {
    return Column(
      children: [
        Image.asset(
          AppIcons.appIcon,
          width: 250,
        ),
        Text(
          "Account Setup Completed",
          style: AppTheme.fontSize(16).makeMedium(),
        ),
        const Gap(30),
        FittedBox(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.curvedTopBarDropShadowColor,
                  blurRadius: 16,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  entity.avatarUrl,
                  width: 70,
                ),
                const Gap(10),
                Text(
                  "@${entity.username}",
                  style: AppTheme.fontSize(20).makeBold(),
                ),
              ],
            ),
          ),
        ),
        const Gap(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CoreAppButton(
              text: "Go to Store",
              onPressed: () {
                setState(() {
                  completedSteps.add(4);
                });
                widget.controller.addUser(
                  entity,
                  widget.state.deviceType,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
