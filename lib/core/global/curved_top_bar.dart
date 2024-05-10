import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class CurvedTopBar extends StatelessWidget {
  const CurvedTopBar({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.curvedTopBarDropShadowColor,
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
