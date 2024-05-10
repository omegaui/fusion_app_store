import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cloud_storage/storage.dart';
import 'package:gap/gap.dart';

class IconContainer extends StatefulWidget {
  const IconContainer({
    super.key,
    required this.bytes,
    required this.onChanged,
  });

  final Uint8List bytes;
  final void Function(dynamic bytes) onChanged;

  @override
  State<IconContainer> createState() => _IconContainerState();
}

class _IconContainerState extends State<IconContainer> {
  bool hover = false;

  late Uint8List bytes;

  @override
  void initState() {
    super.initState();
    bytes = widget.bytes;
  }

  void rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            Storage.pickFiles(
              onDone: (files) async {
                if (files.isNotEmpty) {
                  final file = files.first;
                  bytes = file.bytes ?? bytes;
                  widget.onChanged(bytes);
                  rebuild();
                }
              },
              fileType: FileType.image,
            );
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (e) => setState(() => hover = true),
            onExit: (e) => setState(() => hover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(120),
                border: Border.all(
                  color: hover ? Colors.grey.shade300 : Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(5),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "App Icon",
            style: AppTheme.fontSize(14).makeMedium(),
          ),
        ),
      ],
    );
  }
}
