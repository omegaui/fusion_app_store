import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_controller.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cloud_storage/storage.dart';
import 'package:fusion_app_store/core/global/message_box.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
    required this.appEntity,
    required this.controller,
  });

  final AppEntity appEntity;
  final AppViewPageController controller;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final currentPlatform = defaultTargetPlatform.name;
        final supportedPlatforms =
            widget.appEntity.supportedPlatforms.map((e) => e.type.name);
        if (supportedPlatforms
            .any((e) => e.isCaseInsensitiveContains(currentPlatform))) {
          final path = widget.appEntity.supportedPlatforms
              .where((e) => e.type.name == currentPlatform)
              .first
              .versions
              .first
              .bundleUrl;
          debugPrint(path);
          final url = await Storage.getDownloadUrl(path: path);
          launchUrlString(url);
          showMessage(
            title: "Thank you",
            description: "Your download has already started.",
            type: MessageBoxType.info,
          );
        } else {
          showMessage(
            title: "Unavailable",
            description:
                "This app is unavailable for your $currentPlatform device.",
            type: MessageBoxType.error,
          );
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: !hover
                  ? [
                      const Color(0xFF1EC9FF),
                      const Color(0xFF0A6ECB),
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                    ],
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border.all(
                color: const Color(0xFF444B54).withOpacity(0.2), width: 4),
          ),
          child: Text(
            "Download",
            style: AppTheme.fontSize(20)
                .makeBold()
                .withColor(hover ? Colors.blue : Colors.white)
                .useSen(),
          ),
        ),
      ),
    );
  }
}
