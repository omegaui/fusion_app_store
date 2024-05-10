import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class BentoContainer extends StatelessWidget {
  const BentoContainer({
    super.key,
    required this.width,
    this.height,
    required this.child,
  });

  final double width;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 400,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HomePageTheme.bentoContainerBackground,
        border: Border.all(color: HomePageTheme.bentoContainerBorder, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}
