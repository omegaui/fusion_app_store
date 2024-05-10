import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class DesktopHomeNavBar extends StatefulWidget {
  const DesktopHomeNavBar({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<DesktopHomeNavBar> createState() => _DesktopHomeNavBarState();
}

class _DesktopHomeNavBarState extends State<DesktopHomeNavBar> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: MouseRegion(
        onEnter: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: hover
                ? HomePageTheme.navBarHoverBackground
                : HomePageTheme.navBarBackground,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: HomePageTheme.navBarBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Nav(
                text: "Home",
                onPressed: () {
                  widget.scrollController.animateTo(
                    0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _Nav(
                text: "Why Fusion?",
                onPressed: () {
                  widget.scrollController.animateTo(
                    980,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _Nav(
                text: "Community",
                onPressed: () {
                  widget.scrollController.animateTo(
                    2100,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _Nav(
                text: "About",
                onPressed: () {
                  widget.scrollController.animateTo(
                    3100,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              AppButton(
                text: "Store",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Nav extends StatefulWidget {
  const _Nav({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  State<_Nav> createState() => _NavState();
}

class _NavState extends State<_Nav> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            widget.text,
            style: _getTextStyle(),
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle() {
    if (hover) {
      return HomePageTheme.fontSize(14)
          .makeMedium()
          .withColor(HomePageTheme.navHoverColor);
    }
    return HomePageTheme.fontSize(14).makeMedium();
  }
}
