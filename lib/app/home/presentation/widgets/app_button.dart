import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.fontSize,
    required this.onPressed,
  });

  final String text;
  final Icon? icon;
  final double? fontSize;
  final VoidCallback onPressed;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
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
            color: HomePageTheme.navButtonColor,
            border: Border.all(
              color: !hover
                  ? HomePageTheme.navButtonColor
                  : HomePageTheme.navButtonBorder,
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
                style:
                    HomePageTheme.fontSize(widget.fontSize ?? 14).makeMedium(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
