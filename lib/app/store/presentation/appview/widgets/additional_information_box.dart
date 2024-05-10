import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/pricing_model.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdditionalInformationBox extends StatelessWidget {
  const AdditionalInformationBox({
    super.key,
    required this.publisher,
    required this.appEntity,
  });

  final UserEntity publisher;
  final AppEntity appEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 360,
        margin: const EdgeInsets.symmetric(horizontal: 26),
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 27),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [getBoxesShadow()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 20,
                ),
                const Gap(6),
                Text(
                  "Additional App Information",
                  style: AppTheme.fontSize(20).makeBold().useSen(),
                ),
              ],
            ),
            const Gap(19),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.find<RouteService>().navigateTo(
                          page: RouteService.userPage,
                          parameters: {
                            "id": publisher.username,
                          },
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Publisher",
                              style: AppTheme.fontSize(15).makeBold().useSen(),
                            ),
                            Text(
                              appEntity.maintainer,
                              style:
                                  AppTheme.fontSize(14).makeMedium().useSen(),
                            ),
                            const Gap(10),
                            Text(
                              "Home Page",
                              style: AppTheme.fontSize(15).makeBold().useSen(),
                            ),
                            Text(
                              appEntity.homepage,
                              style:
                                  AppTheme.fontSize(14).makeMedium().useSen(),
                            ),
                            const Gap(10),
                            Text(
                              "Developer Email",
                              style: AppTheme.fontSize(15).makeBold().useSen(),
                            ),
                            Text(
                              appEntity.supportEmail.isEmpty
                                  ? "omegaui22@gmail.com"
                                  : appEntity.supportEmail,
                              style:
                                  AppTheme.fontSize(14).makeMedium().useSen(),
                            ),
                            const Gap(10),
                            Text(
                              "Pricing",
                              style: AppTheme.fontSize(15).makeBold().useSen(),
                            ),
                            const Gap(10),
                            _buildPricingModel(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Purchases",
                          style: AppTheme.fontSize(15).makeBold().useSen(),
                        ),
                        Text(
                          appEntity.inAppPurchaseModel.isEmpty
                              ? "No in-app purchases"
                              : "Contains in-app purchases",
                          style: AppTheme.fontSize(14).makeMedium().useSen(),
                        ),
                        const Gap(10),
                        Text(
                          "Privacy Policy",
                          style: AppTheme.fontSize(15).makeBold().useSen(),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              launchUrlString(publisher.privacyPolicy);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Privacy Policy",
                                  style: AppTheme.fontSize(14)
                                      .makeMedium()
                                      .useSen(),
                                ),
                                const Gap(4),
                                const Icon(
                                  Icons.open_in_new,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "Terms and Conditions",
                          style: AppTheme.fontSize(15).makeBold().useSen(),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              launchUrlString(publisher.termsAndConditions);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Terms & Conditions",
                                  style: AppTheme.fontSize(14)
                                      .makeMedium()
                                      .useSen(),
                                ),
                                const Gap(4),
                                const Icon(
                                  Icons.open_in_new,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          "Address",
                          style: AppTheme.fontSize(15).makeBold().useSen(),
                        ),
                        Text(
                          publisher.address,
                          style: AppTheme.fontSize(14).makeMedium().useSen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingModel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo,
            Colors.blue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: _buildPricingModelContent(),
    );
  }

  Widget _buildPricingModelContent() {
    final pricingModel = appEntity.pricingModel;
    final style =
        AppTheme.fontSize(14).makeBold().withColor(Colors.white).useSen();
    switch (pricingModel.type) {
      case PricingType.paid:
        final hasSubscriptions = pricingModel.price == 0;
        if (hasSubscriptions) {
          return Text(
            "In-app subscription plans",
            style: style,
          );
        } else {
          return Text(
            "Get it for \$${pricingModel.price}",
            style: style,
          );
        }
      case PricingType.free:
        return Text(
          "Get it for free",
          style: style,
        );
    }
  }
}
