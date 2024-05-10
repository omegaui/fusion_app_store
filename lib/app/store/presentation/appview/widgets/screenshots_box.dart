import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/store/presentation/appview/widgets/interactive_image_preview.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ScreenshotsBox extends StatelessWidget {
  const ScreenshotsBox({
    super.key,
    required this.screenshots,
  });

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 980,
      height: 360,
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 27),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [getBoxesShadow()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Screenshots (${screenshots.length})",
            style: AppTheme.fontSize(16).makeBold().useSen(),
          ),
          const Gap(19),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 22.56,
              children:
                  screenshots.map((e) => _ScreenshotTile(url: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreenshotTile extends StatefulWidget {
  const _ScreenshotTile({required this.url});

  final String url;

  @override
  State<_ScreenshotTile> createState() => _ScreenshotTileState();
}

class _ScreenshotTileState extends State<_ScreenshotTile> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.network(
      widget.url,
      fit: BoxFit.contain,
    );
    return GestureDetector(
      onTap: () {
        Get.to(
          InteractiveImagePreview(
            child: imageWidget,
          ),
          routeName: "screenshot-preview",
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.zoomIn,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          scale: hover ? 0.95 : 1.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 250,
              child: imageWidget,
            ),
          ),
        ),
      ),
    );
  }
}
