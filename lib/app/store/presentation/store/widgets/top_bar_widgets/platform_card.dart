import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/config/app_icons.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class PlatformCard extends StatelessWidget {
  const PlatformCard({
    super.key,
    required this.platformType,
    required this.selected,
    required this.onPressed,
  });

  final PlatformType platformType;
  final bool selected;
  final VoidCallback onPressed;

  Image _getImage() {
    const size = 32.0;
    switch (platformType) {
      case PlatformType.windows:
        return Image.asset(
          AppIcons.windows,
          width: size,
          height: size,
        );
      case PlatformType.macos:
        return Image.asset(
          AppIcons.mac,
          width: size,
          height: size,
        );
      case PlatformType.linux:
        return Image.asset(
          AppIcons.linux,
          width: size,
          height: size,
        );
      case PlatformType.android:
        return Image.asset(
          AppIcons.android,
          width: size,
          height: size,
        );
      case PlatformType.web:
        return Image.asset(
          AppIcons.web,
          width: size,
          height: size,
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
            child: _getImage(),
          ),
        ),
      ),
    );
  }
}
