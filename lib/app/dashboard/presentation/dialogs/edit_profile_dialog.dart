import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/config/app_avatars.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/global/ui_utils.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({
    super.key,
    required this.controller,
    required this.state,
  });

  final DashboardPageController controller;
  final DashboardPageInitializedState state;

  static void open(BuildContext context, DashboardPageController controller,
      DashboardPageInitializedState state) async {
    await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) =>
          EditProfileDialog(controller: controller, state: state),
    );
  }

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  bool loaded = true;

  late UserEntity userEntity;

  // form key
  final formKey = GlobalKey<FormState>();

  // controllers
  final userBioController = TextEditingController();
  final userAddressController = TextEditingController();
  final userWebsiteController = TextEditingController();
  final userPrivacyPolicyController = TextEditingController();
  final userTermsAndConditionsController = TextEditingController();
  final mapController = MapController.withUserPosition(
    trackUserLocation: const UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  @override
  void initState() {
    super.initState();
    userEntity = widget.state.userEntity;
    userBioController.text = userEntity.bio;
    userAddressController.text = userEntity.address;
    userWebsiteController.text = userEntity.website;
    userPrivacyPolicyController.text = userEntity.privacyPolicy;
    userTermsAndConditionsController.text = userEntity.termsAndConditions;
    Future(() async {
      await preloadImages(urls: AppAvatars.avatarUrls);
      await preloadImages(urls: [AppIcons.location]);
      loaded = true;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 800,
          height: 700,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 16,
              ),
            ],
          ),
          child: !loaded
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.pink))
              : Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Fusion Profile",
                                  style: AppTheme.fontSize(22).makeBold(),
                                ),
                                const Gap(30),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8F8F8),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Center(
                                            child: Image.network(
                                              userEntity.avatarUrl,
                                              width: 120,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Your Avatar",
                                          style: AppTheme.fontSize(14)
                                              .makeMedium(),
                                        ),
                                      ],
                                    ),
                                    const Gap(40),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 475,
                                          height: 150,
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              runAlignment:
                                                  WrapAlignment.center,
                                              alignment: WrapAlignment.center,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: AppAvatars.avatarUrls
                                                  .map((e) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      userEntity =
                                                          UserEntity.clone(
                                                              userEntity,
                                                              avatarUrl: e);
                                                    });
                                                  },
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: Image.network(
                                                      e,
                                                      width: 48,
                                                      height: 40,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Pick any of them",
                                          style: AppTheme.fontSize(14)
                                              .makeMedium(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(30),
                                Row(
                                  children: [
                                    Text(
                                      "Your Username:",
                                      style: AppTheme.fontSize(14).makeBold(),
                                    ),
                                    const Gap(10),
                                    Text(
                                      userEntity.username,
                                      style: AppTheme.fontSize(14)
                                          .makeMedium()
                                          .useSen(),
                                    ),
                                  ],
                                ),
                                const Gap(15),
                                Row(
                                  children: [
                                    Text(
                                      "Your Login Email:",
                                      style: AppTheme.fontSize(14).makeBold(),
                                    ),
                                    const Gap(10),
                                    Text(
                                      userEntity.userLoginEmail,
                                      style: AppTheme.fontSize(14)
                                          .makeMedium()
                                          .useSen(),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                _textField(
                                  heading: "Your Bio",
                                  controller: userBioController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "*Required";
                                    }
                                    return null;
                                  },
                                  width: 350,
                                  hintText: "A short description of yours.",
                                ),
                                const Gap(20),
                                _textField(
                                  heading: "Your Website",
                                  controller: userWebsiteController,
                                  validator: (value) {
                                    if (value != null &&
                                        Uri.tryParse(value) == null) {
                                      return "Please provide a valid url.";
                                    }
                                    return null;
                                  },
                                  hintText: "A url to your website.",
                                ),
                                const Gap(20),
                                _textField(
                                  heading: "Your Privacy Policy",
                                  controller: userPrivacyPolicyController,
                                  validator: (value) {
                                    if (value != null &&
                                        Uri.tryParse(value) == null) {
                                      return "Please provide a valid url.";
                                    }
                                    return null;
                                  },
                                  hintText: "A url to your privacy policy.",
                                ),
                                const Gap(20),
                                _textField(
                                  heading: "Your Terms and Conditions",
                                  controller: userTermsAndConditionsController,
                                  validator: (value) {
                                    if (value != null &&
                                        Uri.tryParse(value) == null) {
                                      return "Please provide a valid url.";
                                    }
                                    return null;
                                  },
                                  hintText: "A url to your T&C.",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              userEntity = UserEntity.clone(
                                userEntity,
                                bio: userBioController.text,
                                address: userAddressController.text,
                                website: userWebsiteController.text,
                                privacyPolicy: userPrivacyPolicyController.text,
                                termsAndConditions:
                                    userTermsAndConditionsController.text,
                              );
                              widget.controller.updateUser(userEntity);
                              Get.back();
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: AppTheme.fontSize(14)
                                .makeMedium()
                                .withColor(Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppIcons.location,
                              ),
                              const Gap(10),
                              Text(
                                'Your Address',
                                style: AppTheme.fontSize(14).makeMedium(),
                              ),
                              const Gap(10),
                              _textField(
                                controller: userAddressController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required for publishing apps";
                                  }
                                  if (value.length < 10) {
                                    return "*Provide a valid address";
                                  }
                                  return null;
                                },
                                hintText:
                                    "532 S Olive St, Los Angeles, CA 90013",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _textField({
    String? heading,
    required TextEditingController controller,
    required String? Function(String? value)? validator,
    required String? hintText,
    double width = 250,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: getInputDecoration(labelText: heading, hintText: hintText),
        style: AppTheme.fontSize(14).makeMedium().useSen(),
      ),
    );
  }

  InputDecoration getInputDecoration({
    String? labelText,
    String? hintText,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2)),
      hintText: hintText,
      hintStyle: AppTheme.fontSize(14).makeMedium().withColor(Colors.grey),
      labelText: labelText,
      labelStyle: AppTheme.fontSize(14).makeBold(),
    );
  }
}
