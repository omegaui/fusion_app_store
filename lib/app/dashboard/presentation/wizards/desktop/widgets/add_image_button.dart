import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_controller.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cloud_storage/storage.dart';
import 'package:gap/gap.dart';

class AddImageButton extends StatefulWidget {
  const AddImageButton({
    super.key,
    required this.onAdded,
    required this.controller,
    required this.state,
    required this.packageID,
  });

  final void Function(List<PlatformFile> files) onAdded;
  final DashboardPageInitializedState state;
  final String packageID;
  final DashboardPageController controller;

  @override
  State<AddImageButton> createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Storage.pickFiles(
          allowMultiple: true,
          allowedExtensions: ['png'],
          onDone: (files) {
            if (files.isNotEmpty) {
              widget.onAdded(files);
            }
          },
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: hover ? Colors.green : Colors.green.shade50, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100.withOpacity(0.4),
                blurRadius: hover ? 16 : 8,
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
                "Images",
                style: AppTheme.fontSize(16).makeBold().withColor(Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
