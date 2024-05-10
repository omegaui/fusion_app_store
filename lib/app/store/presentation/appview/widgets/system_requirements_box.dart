import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/system_requirements.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SystemRequirementsBox extends StatelessWidget {
  const SystemRequirementsBox({
    super.key,
    required this.minimum,
    required this.maximum,
  });

  final SystemRequirements minimum;
  final SystemRequirements maximum;

  Widget _buildPair(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$key: ",
            style: AppTheme.fontSize(14).makeBold().useSen(),
          ),
          Text(
            value.isEmpty ? "Unspecified" : value,
            style: AppTheme.fontSize(14).makeMedium().useSen(),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementInfo(
    SystemRequirements requirements,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${requirements.type.name.capitalize} System Requirements",
          style: AppTheme.fontSize(16).makeBold().useSen(),
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(
            color: Colors.grey.shade300,
            height: 2,
          ),
        ),
        _buildPair("CPU", requirements.cpu),
        _buildPair("RAM", requirements.ram),
        _buildPair("Architecture", requirements.architecture),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 980,
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
          _buildRequirementInfo(minimum),
          const Gap(20),
          _buildRequirementInfo(maximum),
        ],
      ),
    );
  }
}
