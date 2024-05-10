import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class UploadBundleButton extends StatefulWidget {
  const UploadBundleButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<UploadBundleButton> createState() => _UploadBundleButtonState();
}

class _UploadBundleButtonState extends State<UploadBundleButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Upload Bundle",
      child: GestureDetector(
        onTap: widget.onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (e) => setState(() => hover = true),
          onExit: (e) => setState(() => hover = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeIn,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: hover ? Colors.green : Colors.green.shade300,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: hover ? 48 : 16,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.file_upload_outlined,
                  color: Colors.green,
                ),
                const Gap(8),
                Text(
                  "Bundle",
                  style:
                      AppTheme.fontSize(14).makeBold().withColor(Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
