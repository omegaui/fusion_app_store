import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/presentation/appview/states/appview_page_initialized_state_view.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({
    super.key,
    required this.description,
  });

  final List<String> description;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 420,
      child: Container(
        width: 980,
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
              "Description",
              style: AppTheme.fontSize(16).makeBold().useSen(),
            ),
            const Gap(19),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  description.join('\n'),
                  style: AppTheme.fontSize(14).makeMedium().useSen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
