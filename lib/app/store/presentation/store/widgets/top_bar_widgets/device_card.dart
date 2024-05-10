import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.deviceType,
    required this.selected,
    required this.onPressed,
  });

  final DeviceType deviceType;
  final bool selected;
  final VoidCallback onPressed;

  Icon _getIcon() {
    final color = selected ? Colors.blue.shade800 : Colors.grey.shade800;
    switch (deviceType) {
      case DeviceType.mobile:
        return Icon(
          Icons.phone_android,
          color: color,
        );
      case DeviceType.desktop:
        return Icon(
          Icons.desktop_windows_rounded,
          color: color,
        );
      case DeviceType.tablet:
        return Icon(
          Icons.tablet,
          color: color,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFE6ECF3) : AppTheme.background,
              border: Border.all(
                color: selected ? AppTheme.background : const Color(0xFFE6ECF3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                _getIcon(),
                const Gap(4),
                Text(
                  deviceType.name.capitalize!,
                  style: AppTheme.fontSize(14)
                      .makeMedium()
                      .withColor(selected
                          ? Colors.blue.shade800
                          : Colors.grey.shade800)
                      .useSen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
