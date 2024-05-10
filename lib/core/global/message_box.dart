import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

void showMessage({
  MessageBoxType type = MessageBoxType.info,
  required String title,
  required String description,
  String option1Text = "Ok",
  String option2Text = "Cancel",
  String? option3Text,
  VoidCallback? onOption1Selected,
  VoidCallback? onOption2Selected,
  VoidCallback? onOption3Selected,
}) {
  showDialog(
    context: Get.context!,
    barrierColor: Colors.transparent,
    builder: (context) {
      return MessageBox(
        title: title,
        type: type,
        description: description,
        option1Text: option1Text,
        option2Text: option2Text,
        option3Text: option3Text,
        onOption1Selected: onOption1Selected,
        onOption2Selected: onOption2Selected,
        onOption3Selected: onOption3Selected,
      );
    },
  );
}

enum MessageBoxType { info, warning, error }

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    this.type = MessageBoxType.info,
    required this.title,
    required this.description,
    this.option1Text = "Ok",
    this.option2Text = "Cancel",
    this.option3Text,
    this.onOption1Selected,
    this.onOption2Selected,
    this.onOption3Selected,
  });

  final MessageBoxType type;
  final String title;
  final String description;
  final String option1Text;
  final String option2Text;
  final String? option3Text;
  final VoidCallback? onOption1Selected;
  final VoidCallback? onOption2Selected;
  final VoidCallback? onOption3Selected;

  Widget _getHeader() {
    String? url;
    const size = 32;
    switch (type) {
      case MessageBoxType.info:
        url = "https://img.icons8.com/emoji/$size/bullseye.png";
        break;
      case MessageBoxType.warning:
        url = "https://img.icons8.com/emoji/$size/warning-emoji.png";
        break;
      case MessageBoxType.error:
        url = "https://img.icons8.com/emoji/$size/cross-mark-emoji.png";
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size.toDouble(),
          height: size.toDouble(),
          child: Image.network(
            url,
          ),
        ),
        const Gap(10),
        Text(
          title,
          style: AppTheme.fontSize(18).makeMedium(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 400,
          height: 200,
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: _getShadowColor(),
                blurRadius: 16,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _getHeader(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 60,
                  child: Text(
                    description,
                    maxLines: 5,
                    style: AppTheme.fontSize(14).makeMedium(),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              onOption1Selected?.call();
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8.0),
                              child: Text(
                                option1Text,
                                style: AppTheme.fontSize(14)
                                    .makeMedium()
                                    .withColor(Colors.white),
                              ),
                            ),
                          ),
                          const Gap(10),
                          TextButton(
                            onPressed: () {
                              onOption2Selected?.call();
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8.0),
                              child: Text(
                                option2Text,
                                style: AppTheme.fontSize(14).makeMedium(),
                              ),
                            ),
                          ),
                          if (option3Text != null) ...[
                            const Gap(10),
                            TextButton(
                              onPressed: () {
                                onOption3Selected?.call();
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8.0),
                                child: Text(
                                  option3Text!,
                                  style: AppTheme.fontSize(14).makeMedium(),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getShadowColor() {
    switch (type) {
      case MessageBoxType.info:
        return Colors.blue.shade300;
      case MessageBoxType.warning:
        return Colors.yellow.shade300;
      case MessageBoxType.error:
        return Colors.red.shade300;
    }
  }
}
