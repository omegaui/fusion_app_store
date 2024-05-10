import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({
    super.key,
    required this.iconUrl,
    required this.text,
    required this.onPressed,
    this.vertical = false,
  });

  final String iconUrl;
  final String text;
  final bool vertical;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: vertical
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    iconUrl,
                  ),
                  const Gap(10),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTheme.fontSize(16).makeBold(),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  iconUrl,
                ),
                const Gap(10),
                Text(
                  text,
                  style: AppTheme.fontSize(16).makeBold(),
                ),
              ],
            ),
    );
  }
}
