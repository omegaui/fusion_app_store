import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DashboardNavigationButton extends StatefulWidget {
  const DashboardNavigationButton({
    super.key,
    required this.onPressed,
    required this.activeIconColors,
    required this.icon,
    required this.text,
    required this.active,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final List<Color> activeIconColors;
  final String text;
  final bool active;

  @override
  State<DashboardNavigationButton> createState() =>
      _DashboardNavigationButtonState();
}

class _DashboardNavigationButtonState extends State<DashboardNavigationButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: MouseRegion(
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: FittedBox(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            width: 320,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.dashboardCardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: hover
                    ? AppTheme.dashboardCardHoverColor
                    : AppTheme.dashboardCardColor,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(colors: widget.activeIconColors)
                          .createShader(bounds),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                ),
                const Gap(20),
                Text(
                  widget.text,
                  style: AppTheme.fontSize(16).makeMedium().withColor(hover
                      ? AppTheme.foreground
                      : (widget.active
                          ? AppTheme.dashboardCardActiveBorderColor
                          : AppTheme.dashboardCardTextColor)),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: (widget.active || hover)
                            ? Icon(
                                Icons.keyboard_double_arrow_right_outlined,
                                key: ValueKey("arrow-${DateTime.now()}"),
                                color: AppTheme.dashboardCardTextColor,
                              )
                            : SizedBox(
                                key: ValueKey("${DateTime.now()}"),
                              ),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
