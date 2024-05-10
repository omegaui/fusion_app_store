import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class CoreAppButton extends StatefulWidget {
  const CoreAppButton({
    super.key,
    required this.text,
    this.icon,
    this.fontSize,
    required this.onPressed,
  });

  final String text;
  final Widget? icon;
  final double? fontSize;
  final VoidCallback onPressed;

  @override
  State<CoreAppButton> createState() => _CoreAppButtonState();
}

class _CoreAppButtonState extends State<CoreAppButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        setState(() {
          hover = true;
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              if (mounted) {
                setState(() {
                  hover = false;
                });
              }
            },
          );
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.buttonColor,
            border: Border.all(
              color: !hover ? AppTheme.buttonColor : AppTheme.buttonHoverBorder,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const Gap(8),
              ],
              Text(
                widget.text,
                style: AppTheme.fontSize(widget.fontSize ?? 14)
                    .makeMedium()
                    .withColor(AppTheme.buttonTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
