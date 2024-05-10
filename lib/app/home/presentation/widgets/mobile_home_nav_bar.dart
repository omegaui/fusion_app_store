import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class MobileHomeNavBar extends StatefulWidget {
  const MobileHomeNavBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<MobileHomeNavBar> createState() => _MobileHomeNavBarState();
}

class _MobileHomeNavBarState extends State<MobileHomeNavBar> {
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
              _NavIcon(
                icon: Icon(
                  Icons.home_filled,
                  color: HomePageTheme.foreground,
                ),
                onPressed: () {
                  widget.scrollController.animateTo(
                    0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _NavIcon(
                icon: Icon(
                  Icons.star,
                  color: HomePageTheme.foreground,
                ),
                onPressed: () {
                  widget.scrollController.animateTo(
                    680,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _NavIcon(
                icon: Icon(
                  Icons.people,
                  color: HomePageTheme.foreground,
                ),
                onPressed: () {
                  widget.scrollController.animateTo(
                    2830,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
              _NavIcon(
                icon: Icon(
                  Icons.info,
                  color: HomePageTheme.foreground,
                ),
                onPressed: () {
                  widget.scrollController.animateTo(
                    widget.scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatefulWidget {
  const _NavIcon({
    required this.icon,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final Widget icon;

  @override
  State<_NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<_NavIcon> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            pressed = true;
            widget.onPressed();
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                if (mounted) {
                  setState(() {
                    pressed = false;
                  });
                }
              },
            );
          });
        },
        child: AnimatedScale(
          duration: const Duration(milliseconds: 250),
          scale: pressed ? 0.7 : 1,
          child: widget.icon,
        ),
      ),
    );
  }
}
