import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key, required this.color, required this.onPressed});

  final Color color;
  final VoidCallback onPressed;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          width: 93,
          height: 37,
          decoration: BoxDecoration(
            color: hover ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Follow",
              style: AppTheme.fontSize(16)
                  .makeBold()
                  .useSen()
                  .withColor(hover ? Colors.white : widget.color),
            ),
          ),
        ),
      ),
    );
  }
}
