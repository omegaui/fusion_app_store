import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/permissions.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../states/appview_page_initialized_state_view.dart';

class PermissionsBox extends StatelessWidget {
  const PermissionsBox({
    super.key,
    required this.permissions,
  });

  final Permissions permissions;

  @override
  Widget build(BuildContext context) {
    final permissions = this.permissions.permissions;
    return LimitedBox(
      maxHeight: 190,
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
              "Permissions (${permissions.length})",
              style: AppTheme.fontSize(16).makeBold().useSen(),
            ),
            const Gap(19),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  children: permissions
                      .map((e) => _PermissionTile(permission: e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({required this.permission});

  final Permission permission;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
      width: 200,
      height: 95,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                getPermissionIcon(permission.type),
                color: const Color(0xFF676767),
              ),
              const Gap(4),
              Text(
                permission.type.name.capitalize!,
                style: AppTheme.fontSize(14).makeMedium().useSen(),
              ),
            ],
          ),
          const Gap(4),
          Text(
            permission.description.join('\n').capitalize!,
            maxLines: 2,
            style: AppTheme.fontSize(12).makeMedium().useSen(),
          ),
        ],
      ),
    );
  }
}
